variable "ingress_gateway" {
  description = "(Required) The ingess gateway configuration."
  type = object({
    ip = object({
      value          = string
      resource_group = string
    })
  })
}