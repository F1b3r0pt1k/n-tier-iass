resource "azurerm_network_interface" "jumpbox" {
  name                = "jumpbox-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.jumpbox_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox_pip.id
  }
}

resource "azurerm_public_ip" "jumpbox_pip" {
  allocation_method   = "Static"
  location            = var.location
  name                = "${var.base_name}-jumpbox-pip"
  resource_group_name = var.rg_name
}

resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                            = "${var.base_name}-jumpbox-vm"
  resource_group_name             = var.rg_name
  location                        = var.location
  size                            = "Standard_F2"
  disable_password_authentication = false
  admin_username                  = "azureuser"
  admin_password                  = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.jumpbox.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}