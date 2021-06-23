data "kustomization_overlay" "istio_configuration" {
  for_each = local.manifests

  namespace = kubernetes_namespace.ns.metadata.0.name
  resources = [each.value]
}

resource "kustomization_resource" "istio_configuration" {
  for_each = {
    for m in local.kmanifests : m.id => m.manifest
  }

  manifest = each.value
}

locals {
  kmanifests = flatten([
    for k, v in local.manifests : [
      for id in data.kustomization_overlay.istio_configuration[k].ids : {
        id       = id
        manifest = data.kustomization_overlay.istio_configuration[k].manifests[id]
      }
    ]
  ])

  manifests = {
    authn = "${path.module}/istio-configuration/authorization-policy.yaml"
  }
}