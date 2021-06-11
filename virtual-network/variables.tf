variable "environment" {
  description = "(Required) The environment tag, examples: dev, tst, prd."
  type        = string
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
  type        = map(string)
}