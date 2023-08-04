# Jumpbox NSG Rules
resource "azurerm_network_security_rule" "jumpbox_ssh_allow" {
  name                        = "SSH-Allow"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.jumpbox_nsg.name
}

# App Gateway NSG Rules
resource "azurerm_network_security_rule" "app_gateway_65k_allow" {
  name                        = "65k-Allow"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.appgw_nsg.name
}

# Web NSG Rules

# Business NSG Rules

# Data NSG Rules