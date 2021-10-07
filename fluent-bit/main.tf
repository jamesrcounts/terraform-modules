locals {
  kafka_broker   = "${var.eventhub_namespace_name}.servicebus.windows.net:9093"
  kafka_password = var.eventhub_connection_string
  topic          = var.eventhub_name
}