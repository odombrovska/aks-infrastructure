terraform {
  required_version = ">= 1.3.9"

    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.44.1"
        }

        helm = {
            source  = "hashicorp/helm"
            version = "~> 2.9.0"
        }
    
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "~> 2.18.0"     
        }

        kubectl = {
            source  = "gavinbunney/kubectl"
            version = ">= 1.14.0"
        }
    }
}

data "azurerm_kubernetes_cluster" "credentials" {
    name                = module.aks.aks_cluster_name
    resource_group_name = module.aks.aks_cluster_resource_group_name
}

provider "azurerm" {
    features {}
}

provider "kubernetes" {
    host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
    host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)  
    load_config_file       = false
}

provider "helm" {
    kubernetes {
        host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
        client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
        client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
        cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)    
    }
}