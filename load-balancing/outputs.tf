output "web_biz_lb" {
  value = azurerm_lb.web_biz_lb
}

output "web_biz_lb_pool_ids" {
  value = azurerm_lb_backend_address_pool.web_biz_lb.id
}