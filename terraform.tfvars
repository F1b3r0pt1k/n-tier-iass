### Root Module
rg_name   = "ntier-iaas-rg"
base_name = "ntier-iaas"
location  = "westus2"

### Network Module
vnet_name                        = "ntier-iaas-vnet"
vnet_address_space               = ["10.9.0.0/16"]
jumpbox_subnet_address_prefixes  = ["10.9.0.0/24"]
appgw_subnet_address_prefixes    = ["10.9.1.0/24"]
web_subnet_address_prefixes      = ["10.9.2.0/24"]
business_subnet_address_prefixes = ["10.9.3.0/24"]
data_subnet_address_prefixes     = ["10.9.4.0/24"]

### Jumpbox Module
admin_password = "ZAQ!XSW@cde3"

### Web Module

### Business Module

### Data Module
administrator_login = "sqladmin"
administrator_login_password = "ZAQ!XSW@cde3"

### App Gateway Module
