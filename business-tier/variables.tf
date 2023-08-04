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

variable "business_subnet_id" {
  type        = string
  description = "ID of the subnet to deploy the business tier into."
}

variable "load_balancer_backend_address_pool_ids" {
  type        = list(string)
  description = "IDs of the backend address pools to associate with the load balancer."
}

variable "web_biz_lb_pool_ids" {
  type        = string
  description = "IDs of the backend address pools to associate with the load balancer."
}