resource "random_string" "unique_id" {
    length  = 5
    special = false
    upper   = false
}

data "azurerm_key_vault_secret" "sql_admin_user_secret" {
    name         = var.sql_admin_user_secret_name
    key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "sql_admin_password_secret" {
    name         = var.sql_admin_password_secret_name
    key_vault_id = var.key_vault_id
}

resource "azurerm_mssql_server" "server" {
    name                         = lower("${var.environment}-sqlserver-${random_string.unique_id.result}")
    resource_group_name          = var.resource_group_name
    location                     = var.location
    version                      = "12.0"
    administrator_login          = data.azurerm_key_vault_secret.sql_admin_user_secret.value
    administrator_login_password = data.azurerm_key_vault_secret.sql_admin_password_secret.value
}

resource "azurerm_mssql_database" "database" {
    name                        = lower("${var.environment}-sqldb-${random_string.unique_id.result}")
    server_id                   = azurerm_mssql_server.server.id
    read_scale                  = false
    zone_redundant              = false
    sku_name                    = "GP_S_Gen5_1"
    min_capacity                = 1
    auto_pause_delay_in_minutes = 60
    collation                   = "SQL_Latin1_General_CP1_CI_AS"
}

