variable "domains" {
  description = "(Required) Custom domain configuration for this API Management instance."
  type = object({
    portal = object({
      host_name = string
      secret_id = string
    })
    gateway = object({
      host_name = string
      secret_id = string
    })
  })
}

variable "log_analytics_workspace" {
  description = "(Required) The module will use this log analytics workspace to configure diagnostics and Container Insights."
  type = object({
    id                  = string
    name                = string
    location            = string
    resource_group_name = string
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

variable "subnet" {
  description = "(Required) The virtual network subnet for the APIM resource."
  type = object({
    id = string
  })
}