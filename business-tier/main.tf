resource "azurerm_linux_virtual_machine_scale_set" "business_vmss" {
  name                            = "${var.base_name}-business-vmss"
  resource_group_name             = var.rg_name
  location                        = var.location
  sku                             = "Standard_F2"
  instances                       = 1
  disable_password_authentication = false
  admin_username                  = "azureuser"
  admin_password                  = var.admin_password

  zones        = [1, 2, 3]
  zone_balance = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "business-vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.business_subnet_id
      load_balancer_backend_address_pool_ids = [var.web_biz_lb_pool_ids]
    }
  }
}

resource "azurerm_monitor_autoscale_setting" "business_scale_rule" {
  location            = var.location
  name                = "${var.base_name}-business-autoscale-config"
  resource_group_name = var.rg_name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.business_vmss.id
  profile {
    name = "businessAutoScale"
    capacity {
      default = 2
      maximum = 5
      minimum = 1
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.business_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 80
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.business_vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 20
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}