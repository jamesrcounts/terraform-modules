resource "helm_release" "fluent_bit" {
  atomic    = true
  chart     = "${path.module}/charts/fluent-bit-${var.chart_version}"
  lint      = true
  name      = "fluent-bit"
  namespace = var.kubernetes_namespace

  set_sensitive {
    name  = "config.outputs"
    value = <<EOF
[OUTPUT]
    Name        kafka
    Match       *
    Brokers     ${local.kafka_broker}
    Topics      ${local.topic}
    Retry_Limit    2
    rdkafka.security.protocol SASL_SSL
    rdkafka.sasl.mechanism PLAIN
    rdkafka.sasl.username $ConnectionString
    rdkafka.sasl.password ${local.kafka_password}
    rdkafka.ssl.sa.location /usr/lib/ssl/certs/
    rdkafka.auto.offset.reset end
    rdkafka.request.timeout.ms 60000
    rdkafka.log.connection.close false
    rdkafka.queue.buffering.max.ms 1000
    rdkafka.queue.buffering.max.messages 300
    rdkafka.batch.num.messages 200
    rdkafka.compression.codec none
    rdkafka.request.required.acks 1
    rdkafka.queue.buffering.max.kbytes 10240
EOF
  }
}