variable "environment" {
  description = "(Required) The environment tag, examples: dev, tst, prd."
  type        = string
}

variable "log_analytics_workspace" {
  description = "(Required) The module will use this log analytics workspace to configure diagnostics."
  type = object({
    id = string
  })
}

variable "resource_group" {
  description = "(Required) The module will deploy resources into this resource group and copy tags from this resource group onto the resources."
  type = object({
    id       = string
    name     = string
    location = string
    tags     = map(string)
  })
}

variable "subnets" {
  description = "(Required) The subnets to create within the virtual network."
  type = map(object({
    bits                    = number
    enable_private_endpoint = bool
    net                     = number
  }))
}