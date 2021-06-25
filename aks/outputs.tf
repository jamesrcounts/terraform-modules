output "load_balancer_ip_address" {
  value = azurerm_public_ip.aks.ip_address
}