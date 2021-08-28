variable "ingress_gateway" {
  description = "(Required) The ingess gateway configuration."
  type = object({
    namespace = string
    ip = object({
      value          = string
      resource_group = string
    })
  })
}

variable "revision" {
  description = "(Required) The control plane revision ID."
  type        = string
}