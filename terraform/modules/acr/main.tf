resource "random_string" "unique_id" {
    length  = 5
    special = false
    upper   = false
}

resource "azurerm_container_registry" "registry" {
    name                = lower("${var.environment}acr${random_string.unique_id.result}")
    resource_group_name = var.resource_group_name
    location            = var.location
    sku                 = "Standard"
    admin_enabled       = true
}
