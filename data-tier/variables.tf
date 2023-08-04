variable "rg_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Location of the resource group."
}

variable "base_name" {
  type        = string
  description = "Base name for all resources."
}

variable "administrator_login" {
  type        = string
  description = "Administrator login for the SQL Server."
}

variable "administrator_login_password" {
  type        = string
  description = "Administrator login password for the SQL Server."
}
