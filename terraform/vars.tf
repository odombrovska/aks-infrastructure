variable "location"  {
    type        = string
    description = "The location for the resources."
}

variable "resource_group_name"  {
    type        = string
    description = "The name of the resource group for your infrastructure resources."
}

variable "environment"  {
    type        = string
    description = "The name of the environment for this deployment."
}

variable "kubernetes_version" {
    type        = string
    description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region."
    default     = "1.25.5"
}

variable "aks_sku_tier" {
    description = "The SKU tier that should be used for this cluster."
    type        = string
    default     = "Free"
}

variable "private_cluster_enabled" {
    description = "Select if deploying a private AKS cluster."
    type        = bool
    default     = false
}

variable "aks_node_size" {
    description = "The size of VMs to be used within the node pool."
    type        = string
    default     = "Standard_B4ms"
}

variable "aks_nodes_count" {
    description = "The number of nodes that should exist in the agent pool."
    type        = number
    default     = 1
}

variable "sql_admin_user_secret_name" {
    type        = string
    description = "The name of the SQL admin user secret."
    default     = "SQL-ADMIN-USERNAME"
}

variable "sql_admin_password_secret_name" {
    type        = string
    description = "The name of the SQL admin password secret."
    default     = "SQL-ADMIN-PASSWORD"
}

variable "sql_admin_username" {
    type        = string
    description = "The username of the SQL admin user."
    default     = "sqladmin"
}

variable "namespaces" {
    description = "The names of the K8s namespaces that host the deployments."
    type        = list
    default     = [ "applications", "nginx-ingress", "cert-manager" ]
}