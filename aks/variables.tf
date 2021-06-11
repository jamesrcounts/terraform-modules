// variable "cert_secret_id" {
//   description = "(Required) The secret id for the key vault secret containing the certificate an private key for this deployment."
//   type        = string
// }

variable "environment" {
  description = "(Required) The environment tag, examples: dev, tst, prd."
  type        = string
}

// variable "log_analytics_workspace" {
//   description = "(Required) The module will use this log analytics workspace to configure diagnostics and Container Insights."
//   type = object({
//     id   = string
//     name = string
//   })
// }

// variable "configuration_resource_group" {
//   description = "(Required) The module will read configuration data from this resource group."
//   type = object({
//     id       = string
//     name     = string
//     location = string
//     tags     = map(string)
//   })
// }

// variable "resource_group" {
//   description = "(Required) The module will deploy resources into this resource group and copy tags from this resource group onto the resources."
//   type = object({
//     id       = string
//     name     = string
//     location = string
//     tags     = map(string)
//   })
// }

variable "instance_id" {
  type        = string
  description = "(Required) Unique ID for this instance."
}
