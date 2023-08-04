resource "random_string" "data_tier" {
  length           = 4
  special          = false
  upper = false
}

resource "azurerm_user_assigned_identity" "sql_identity" {
  name                = "sqladmin"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_storage_account" "data_tier" {
  name                     = "datatierstg${random_string.data_tier.result}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "data_tier" {
  name                         = "data-tier-sqlserver"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sql_identity.id]
  }

  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.sql_identity.id
#  transparent_data_encryption_key_vault_key_id = azurerm_key_vault_key.example.id
}

resource "azurerm_mssql_database" "data_tier" {
  name           = "db01"
  server_id      = azurerm_mssql_server.data_tier.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true
}