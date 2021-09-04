output "subnets" {
  value = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}