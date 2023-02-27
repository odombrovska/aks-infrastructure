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