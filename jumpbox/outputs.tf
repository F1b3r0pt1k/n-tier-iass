output "jumpbox_public_ip" {
  value = azurerm_public_ip.jumpbox_pip.ip_address
}
