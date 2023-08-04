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

variable "web_subnet_id" {
  type        = string
  description = "ID of the subnet to deploy the web tier into."
}

variable "appgw_subnet_id" {
  type        = string
  description = "ID of the subnet to deploy the app gateway into."
}

variable "backend_address_pool_name" {
  default = "myBackendPool"
}

variable "frontend_port_name" {
  default = "myFrontendPort"
}

variable "frontend_ip_configuration_name" {
  default = "myAGIPConfig"
}

variable "http_setting_name" {
  default = "myHTTPsetting"
}

variable "listener_name" {
  default = "myListener"
}

variable "request_routing_rule_name" {
  default = "myRoutingRule"
}

variable "web_nsg_id" {
  type        = string
  description = "ID of the network security group to apply to the web tier."
}
