variable "admin_password" {
  type        = string
  description = "The password for the admin user on the jumpbox"
}

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

variable "jumpbox_subnet_id" {
  type        = string
  description = "ID of the subnet to deploy the jumpbox into."
}
