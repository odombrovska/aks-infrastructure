terraform {
    backend "azurerm" {}
}

locals {
    resource_group_name = lower(var.resource_group_name)
}


resource "azurerm_resource_group" "resource_group" {
    name     = local.resource_group_name
    location = var.location
}

module "acr" {
    depends_on = [
        azurerm_resource_group.resource_group
    ]

    source = "./modules/acr"
    
    resource_group_name = local.resource_group_name
    location            = var.location
    environment         = var.environment
}

module "kv" {
    depends_on = [
        azurerm_resource_group.resource_group
    ]
    
    source = "./modules/kv"
    
    resource_group_name = local.resource_group_name
    location            = var.location
    environment         = var.environment 
}

module "kv-secrets" {
    depends_on = [
        module.kv
    ]
    
    source = "./modules/kv-secrets"
    
    key_vault_id                   = module.kv.kv_id
    sql_admin_user_secret_name     = var.sql_admin_user_secret_name
    sql_admin_password_secret_name = var.sql_admin_password_secret_name
    sql_admin_username             = var.sql_admin_username
}

module "storage" {
    depends_on = [
        azurerm_resource_group.resource_group
    ]
    
    source = "./modules/storage"
    
    resource_group_name = local.resource_group_name
    location            = var.location
    environment         = var.environment
}

resource "time_sleep" "wait_for_secrets" {
    create_duration = "30s"
    depends_on = [
        module.kv-secrets
    ]
}

module "mssql"  {
    depends_on = [
        time_sleep.wait_for_secrets
    ]
    
    source = "./modules/mssql"
    
    resource_group_name            = local.resource_group_name
    location                       = var.location
    environment                    = var.environment
    key_vault_id                   = module.kv.kv_id
    sql_admin_user_secret_name     = var.sql_admin_user_secret_name
    sql_admin_password_secret_name = var.sql_admin_password_secret_name
}

module "pip" {
    depends_on = [
        module.aks
    ]
  
    source = "./modules/pip"

    resource_group_name = module.aks.aks_nodegroup_name
    location            = var.location
    environment         = var.environment
}

module "aks"  {
    depends_on = [
        module.acr
    ]
    
    source = "./modules/aks"
    
    resource_group_name     = local.resource_group_name
    location                = var.location
    environment             = var.environment
    kubernetes_version      = var.kubernetes_version
    sku_tier                = var.aks_sku_tier
    private_cluster_enabled = var.private_cluster_enabled
    node_size               = var.aks_node_size
    nodes_count             = var.aks_nodes_count
    acr_id                  = module.acr.acr_id
}

module "namespaces" {
    depends_on = [
        module.aks
    ]

    source = "./modules/k8s/namespaces"

    namespaces = var.namespaces
}

module "nginx-ingress" {
    depends_on = [
        module.namespaces
    ]

    source = "./modules/k8s/nginx-ingress"

    public_ip_address = module.pip.pip
}

module "cert-manager" {
    depends_on = [
        module.namespaces
    ]

    source = "./modules/k8s/cert-manager"
}