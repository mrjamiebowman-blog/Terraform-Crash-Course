resource "azurerm_resource_group" "rg" {
  name     = "ResourceGroupK8s"
  location = "Central US"
}
 
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "AksK8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksdns"
 
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B1s"
  }
 
  identity {
    type = "SystemAssigned"
  }
 
  tags = {
    Environment = var.environment
  }
}
 
output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate  
}
 
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}