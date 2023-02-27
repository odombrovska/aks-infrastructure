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

variable "nodes_count" {
    description = "The number of nodes that should exist in the agent pool."
    type        = number
}

variable "node_size" {
    description = "The size of VMs to be used within the node pool."
    type        = string
}

variable "private_cluster_enabled" {
    description = "Select if deploying a private AKS cluster."
    type        = bool
}

variable "sku_tier" {
    description = "The SKU tier that should be used for this cluster."
    type        = string
}

variable "kubernetes_version" {
    description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region."
    type        = string
}

variable "acr_id" {
    description = "The ID of the Azure Container Registry to attach to the cluster."
    type        = string
}
