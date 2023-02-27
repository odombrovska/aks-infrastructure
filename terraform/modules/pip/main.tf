resource "random_string" "unique_id" {
    length  = 5
    special = false
    upper   = false
}

resource "azurerm_public_ip" "pip" {
    name                = lower("${var.environment}-pip-${random_string.unique_id.result}")
    resource_group_name = var.resource_group_name
    location            = var.location
    allocation_method   = "Static"
    sku                 = "Standard"
}