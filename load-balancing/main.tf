resource "azurerm_lb" "web_biz_lb" {
  name                = "${var.base_name}web-biz-lb"
  location            = var.location
  resource_group_name = var.rg_name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "${var.base_name}web-biz-ipconfig"
    subnet_id = var.web_subnet_id
  }
}

resource "azurerm_lb_backend_address_pool" "web_biz_lb" {
  loadbalancer_id     = azurerm_lb.web_biz_lb.id
  name                = "bepool"
}

resource "azurerm_lb_nat_rule" "web_biz_lb" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.web_biz_lb.id
  name                           = "SSH"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "${var.base_name}web-biz-ipconfig"
}

resource "azurerm_lb_rule" "web_biz_lb" {
  loadbalancer_id                = azurerm_lb.web_biz_lb.id
  name                           = "HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_biz_lb.id]
  frontend_ip_configuration_name = "${var.base_name}web-biz-ipconfig"
}

resource "azurerm_lb_probe" "web_biz_lb" {
  loadbalancer_id = azurerm_lb.web_biz_lb.id
  name            = "ssh-running-probe"
  port            = 22
}