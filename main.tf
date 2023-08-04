resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.rg_name
}

module "network" {
  source                           = "./network"
  location                         = var.location
  rg_name                          = azurerm_resource_group.rg.name
  base_name                        = var.base_name
  vnet_address_space               = var.vnet_address_space
  vnet_name                        = var.vnet_name
  jumpbox_subnet_address_prefixes  = var.jumpbox_subnet_address_prefixes
  web_subnet_address_prefixes      = var.web_subnet_address_prefixes
  business_subnet_address_prefixes = var.business_subnet_address_prefixes
  data_subnet_address_prefixes     = var.data_subnet_address_prefixes
  appgw_subnet_address_prefixes    = var.appgw_subnet_address_prefixes
  depends_on                       = [azurerm_resource_group.rg]
}

module "jumpbox" {
  source            = "./jumpbox"
  location          = var.location
  rg_name           = var.rg_name
  base_name         = var.base_name
  admin_password    = var.admin_password
  jumpbox_subnet_id = module.network.jumpbox_subnet_id
  depends_on        = [azurerm_resource_group.rg]
}

module "web_tier" {
  source          = "./web-tier"
  location        = var.location
  rg_name         = var.rg_name
  base_name       = var.base_name
  admin_password  = var.admin_password
  web_subnet_id   = module.network.web_subnet_id
  web_nsg_id      = module.network.web_nsg_id
  appgw_subnet_id = module.network.appgw_subnet_id
  depends_on      = [azurerm_resource_group.rg]
}

module "business_tier" {
  source                                 = "./business-tier"
  location                               = var.location
  rg_name                                = var.rg_name
  base_name                              = var.base_name
  admin_password                         = var.admin_password
  business_subnet_id                     = module.network.business_subnet_id
  web_biz_lb_pool_ids                    = module.load-balancing.web_biz_lb_pool_ids
  load_balancer_backend_address_pool_ids = [module.load-balancing.web_biz_lb_pool_ids]
  depends_on                             = [azurerm_resource_group.rg]
}

module "load-balancing" {
  source        = "./load-balancing"
  location      = var.location
  rg_name       = var.rg_name
  base_name     = var.base_name
  web_subnet_id = module.network.web_subnet_id
  depends_on    = [azurerm_resource_group.rg]
}

module "data_tier" {
  source                       = "./data-tier"
  location                     = var.location
  rg_name                      = var.rg_name
  base_name                    = var.base_name
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  depends_on                   = [azurerm_resource_group.rg]
}