output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "aks_name" {
  value = module.aks.name
}

output "kubeconfig" {
  value     = module.aks.kubeconfig
  sensitive = true
}
