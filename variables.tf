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

# VNet Variables

variable "vnet_address_space" {
  type        = list(any)
  description = "The address space that is used the virtual network."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "jumpbox_subnet_address_prefixes" {
  type        = list(any)
  description = "The address prefix to use for the jumpbox subnet."
}

variable "web_subnet_address_prefixes" {
  type        = list(any)
  description = "The address prefix to use for the web subnet."
}

variable "business_subnet_address_prefixes" {
  type        = list(any)
  description = "The address prefix to use for the business subnet."
}

variable "data_subnet_address_prefixes" {
  type        = list(any)
  description = "The address prefix to use for the data subnet."
}

variable "appgw_subnet_address_prefixes" {
  type        = list(any)
  description = "The address prefix to use for the app gateway subnet."
}

# Jumpbox Variables
variable "admin_password" {
  type        = string
  description = "The password for the admin user on the jumpbox"
}

# Web Tier Variables

# Business Tier Variables

# Data Tier Variables
variable "administrator_login" {
  type        = string
  description = "Administrator login for the SQL Server."
}

variable "administrator_login_password" {
  type        = string
  description = "Administrator login password for the SQL Server."
}


# App Gateway Variables