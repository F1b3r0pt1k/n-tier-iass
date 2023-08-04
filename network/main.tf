### VNet for N-Tier Architecture

resource "azurerm_virtual_network" "vnet" {
  address_space       = var.vnet_address_space
  location            = var.location
  name                = var.vnet_name
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "jumpbox_subnet" {
  address_prefixes     = var.jumpbox_subnet_address_prefixes
  name                 = "${var.base_name}-JumpboxSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "web_subnet" {
  address_prefixes     = var.web_subnet_address_prefixes
  name                 = "${var.base_name}-WebSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "business_subnet" {
  address_prefixes     = var.business_subnet_address_prefixes
  name                 = "${var.base_name}-BusinessSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "data_subnet" {
  address_prefixes     = var.data_subnet_address_prefixes
  name                 = "${var.base_name}-DataSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "appgw_subnet" {
  address_prefixes     = var.appgw_subnet_address_prefixes
  name                 = "ApplicationGatewaySubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "appgw_nsg" {
  location            = var.location
  name                = "${var.base_name}-appgw-nsg"
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "jumpbox_nsg" {
  location            = var.location
  name                = "${var.base_name}-jumpbox-nsg"
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "web_nsg" {
  location            = var.location
  name                = "${var.base_name}-web-nsg"
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "business_nsg" {
  location            = var.location
  name                = "${var.base_name}-business-nsg"
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "data_nsg" {
  location            = var.location
  name                = "${var.base_name}-data-nsg"
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "appgw_assoc" {
  network_security_group_id = azurerm_network_security_group.appgw_nsg.id
  subnet_id                 = azurerm_subnet.appgw_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "jumpbox_assoc" {
  network_security_group_id = azurerm_network_security_group.jumpbox_nsg.id
  subnet_id                 = azurerm_subnet.jumpbox_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "web_assoc" {
  network_security_group_id = azurerm_network_security_group.web_nsg.id
  subnet_id                 = azurerm_subnet.web_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "business_assoc" {
  network_security_group_id = azurerm_network_security_group.business_nsg.id
  subnet_id                 = azurerm_subnet.business_subnet.id
}

resource "azurerm_subnet_network_security_group_association" "data_assoc" {
  network_security_group_id = azurerm_network_security_group.data_nsg.id
  subnet_id                 = azurerm_subnet.data_subnet.id
}