variable "eventhub_connection_string" {
  description = "(Required) A connection string for an Event Hubs authorization Rule with permission to send. Fluent Bit uses this as the Kafka password."
  type        = string
}

variable "eventhub_name" {
  description = "(Required) The name of the EventHub. Fluent Bit uses this as the Kafka topic."
  type        = string
}