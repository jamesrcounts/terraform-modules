data "kustomization_overlay" "istio_configuration" {
  namespace = kubernetes_namespace.ns.metadata.0.name
  resources = ["${path.module}/istio-configuration/authorization-policy.yaml"]
}

resource "kustomization_resource" "istio_configuration" {
  count = 1

  manifest = data.kustomization_overlay.istio_configuration.manifests[count.index]
}

