resource "random_string" "sql_admin_password" {
    length  = 16
    special = true
    upper   = false
}

resource "azurerm_key_vault_secret" "sql_admin_user_secret" {
    name         = var.sql_admin_user_secret_name
    value        = var.sql_admin_username
    key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sql_admin_password_secret" {
    name         = var.sql_admin_password_secret_name
    value        = random_string.sql_admin_password.result
    key_vault_id = var.key_vault_id
}