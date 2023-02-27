resource "random_string" "unique_id" {
    length  = 5
    special = false
    upper   = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
    name                = lower("${var.environment}-kv-${random_string.unique_id.result}")
    location            = var.location
    resource_group_name = var.resource_group_name
    tenant_id           = data.azurerm_client_config.current.tenant_id
    sku_name            = "standard"
}

resource "azurerm_key_vault_access_policy" "example" {
    key_vault_id = azurerm_key_vault.vault.id
    tenant_id    = data.azurerm_client_config.current.tenant_id
    object_id    = data.azurerm_client_config.current.object_id

    secret_permissions = [
        "Get",
        "Set"
    ]
}