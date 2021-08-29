variable "additional_imports" {
  default     = []
  description = "(Optional) Additional keys to lookup in the configuration store"
  type        = list(string)
}

variable "instance_id" {
  description = "(Required) The identifier for the backend resources that support this environment."
  type        = string
}