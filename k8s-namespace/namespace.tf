resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.name

    labels = {
      istio-injection = "enabled"
      name            = var.name
    }
  }
}