data "kustomization" "istio" {
  path = "${path.module}/istio"
}

resource "kustomization_resource" "istio" {
  for_each   = data.kustomization.istio.ids
  manifest   = data.kustomization.istio.manifests[each.value]
  depends_on = [kustomization_resource.istio_operator, kubernetes_namespace.istio_system]
}