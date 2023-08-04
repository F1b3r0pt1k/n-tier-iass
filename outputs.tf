# Jumpbox public IP address.
output "jumpbox_public_ip" {
  value = module.jumpbox.jumpbox_public_ip
}
