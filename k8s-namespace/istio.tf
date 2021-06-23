data "kustomization_overlay" "istio_configuration" {
  namespace = kubernetes_namespace.ns.metadata.0.name
  resources = [for k, v in local.manifests : v.path]
}

resource "kustomization_resource" "istio_configuration" {
  for_each = local.manifests

  manifest = data.kustomization_overlay.istio_configuration.manifests[each.value.id]
}

locals {
  manifests = {
    authn = {
      id   = "security.istio.io_v1beta1_AuthorizationPolicy|${kubernetes_namespace.ns.metadata.0.name}|allow-nothing"
      path = "${path.module}/istio-configuration/authorization-policy.yaml"
    }
  }
}