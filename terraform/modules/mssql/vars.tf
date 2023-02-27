variable "resource_group_name" {
    description = "The resource group name."
    type        = string
}

variable "location" {
    description = "Location of the cluster."
    type        = string
}

variable "environment" {
    type        = string
    description = "The name of the environment for this deployment."
}

variable "key_vault_id" {
    type        = string
    description = "The ID of the Azure Key Vault."
}

variable "sql_admin_user_secret_name" {
    type        = string
    description = "The name of the SQL admin user secret."
}

variable "sql_admin_password_secret_name" {
    type        = string
    description = "The name of the SQL admin password secret."
}