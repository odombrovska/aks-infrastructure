variable "sql_admin_user_secret_name" {
    type        = string
    description = "The name of the SQL admin user secret."
}

variable "sql_admin_password_secret_name" {
    type        = string
    description = "The name of the SQL admin password."
}

variable "sql_admin_username" {
    type        = string
    description = "The username of the SQL admin user."
}

variable "key_vault_id" {
    type        = string
    description = "The ID of the Azure Key Vault."
}