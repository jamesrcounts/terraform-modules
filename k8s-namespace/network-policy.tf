resource "kubernetes_network_policy" "default_deny_all" {
  metadata {
    name      = "default-deny-all"
    namespace = kubernetes_namespace.ns.metadata.0.name
  }

  spec {
    pod_selector {}
    policy_types = ["Ingress", "Egress"]
  }
}