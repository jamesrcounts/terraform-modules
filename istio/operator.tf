data "kustomization" "istio_operator" {
  path = "${path.module}/istio-operator"
}

resource "kustomization_resource" "istio_operator" {
  for_each = data.kustomization.istio_operator.ids
  manifest = data.kustomization.istio_operator.manifests[each.value]
}
