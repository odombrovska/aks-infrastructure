output "aks_cluster_name" {
    value = azurerm_kubernetes_cluster.main.name
}

output "aks_cluster_resource_group_name" {
    value = azurerm_kubernetes_cluster.main.resource_group_name
}

output "aks_nodegroup_name" {
    value = azurerm_kubernetes_cluster.main.node_resource_group
}