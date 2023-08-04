### Initially had the App Gateway in a separate module, but it was causing issues with the VMSS.
### So moved to the web-tier module.

resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.base_name}-appgw-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_application_gateway" "appgw" {
  name                = "${var.base_name}-appgw"
  resource_group_name = var.rg_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "${var.base_name}-appgw-ipconfig"
    subnet_id = var.appgw_subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = var.backend_address_pool_name

  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.http_setting_name
    priority                   = 1
  }
}
/* 
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic-assoc" {
  network_interface_id    = azurerm_linux_virtual_machine_scale_set.web_vmss.network_interface[0]
  ip_configuration_name   = "bepool-nic-ipconfig"
  backend_address_pool_id = azurerm_application_gateway.appgw.backend_address_pool[0].id
} */
