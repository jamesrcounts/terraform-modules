data "kustomization_overlay" "istio_configuration" {
  namespace = kubernetes_namespace.ns.metadata.0.name
  resources = ["${path.module}/istio-configuration/authorization-policy.yaml"]
}

resource "kustomization_resource" "istio_configuration" {
  for_each = data.kustomization_overlay.istio_configuration.manifests

  manifest = each.value
}

