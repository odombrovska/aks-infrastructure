resource "random_string" "unique_id" {
    length  = 5
    special = false
    upper   = false
}

resource "azurerm_storage_account" "storage" {
    name                      = lower("${var.environment}storage${random_string.unique_id.result}")
    resource_group_name       = var.resource_group_name
    location                  = var.location
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    access_tier               = "Hot"
}