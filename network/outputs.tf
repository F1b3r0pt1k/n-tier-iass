output "jumpbox_subnet_id" {
  value = azurerm_subnet.jumpbox_subnet.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw_subnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}

output "business_subnet_id" {
  value = azurerm_subnet.business_subnet.id
}

output "data_subnet_id" {
  value = azurerm_subnet.data_subnet.id
}

output "jumpbox_nsg_id" {
  value = azurerm_network_security_group.jumpbox_nsg.id
}

output "appgw_nsg_id" {
  value = azurerm_network_security_group.appgw_nsg.id
}

output "web_nsg_id" {
  value = azurerm_network_security_group.web_nsg.id
}

output "business_nsg_id" {
  value = azurerm_network_security_group.business_nsg.id
}

output "data_nsg_id" {
  value = azurerm_network_security_group.data_nsg.id
}

