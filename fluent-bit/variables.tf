variable "chart_version" {
  default     = "0.19.0"
  description = "(Optional) The chart version to install.  Defaults to `0.19.0`."
  type        = string
}

variable "eventhub_connection_string" {
  description = "(Required) A connection string for an Event Hubs authorization Rule with permission to send. Fluent Bit uses this as the Kafka password."
  type        = string
}

variable "eventhub_name" {
  description = "(Required) The name of the EventHub. Fluent Bit uses this as the Kafka topic."
  type        = string
}

variable "eventhub_namespace_name" {
  description = "(Required) The name of the EventHub Namespace. Fluent Bit uses this as the Kafka broker."
  type        = string
}

variable "kubernetes_namespace" {
  description = "(Required) The namespace to install the release into."
  type        = string
}