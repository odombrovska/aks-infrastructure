resource "random_string" "unique_id" {
    length  = 5
    special = false
    upper   = false
}

resource "azurerm_kubernetes_cluster" "main" {
    name                    = lower("${var.environment}-aks-${random_string.unique_id.result}")
    kubernetes_version      = var.kubernetes_version
    location                = var.location
    resource_group_name     = var.resource_group_name
    sku_tier                = var.sku_tier
    private_cluster_enabled = var.private_cluster_enabled
    dns_prefix              = lower("${var.environment}-aks-${random_string.unique_id.result}-dns")
    azure_policy_enabled    = true

    default_node_pool {
        name       = "default"
        node_count = var.nodes_count
        vm_size    = var.node_size
    }

    identity {
        type = "SystemAssigned"
    } 
}

resource "azurerm_role_assignment" "assignment" {
    principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
    role_definition_name             = "AcrPull"
    scope                            = var.acr_id
    skip_service_principal_aad_check = true
}