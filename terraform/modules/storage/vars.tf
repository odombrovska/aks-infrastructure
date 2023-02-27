variable "resource_group_name"  {
    type        = string
    description = "The name of the resource group for your resources."
}

variable "location"  {
    type        = string
    description = "The location for the resources."
}

variable "environment"  {
    type        = string
    description = "The name of the environment for this deployment."
}