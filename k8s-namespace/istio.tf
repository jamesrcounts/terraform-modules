// resource "local_file" "policy" {
//   content = templatefile(
//     "${path.module}/istio-configuration/authorization-policy.yaml.hcl",
//     {
//       namespace = kubernetes_namespace.ns.metadata.0.name
//     }
//   )
//   filename = "${path.module}/istio-configuration/authorization-policy.yaml"
// }

// data "kustomization_build" "istio_configuration" {
//   path = "${path.module}/istio-configuration"
// }

data "kustomization_overlay" "istio_configuration" {
  namespace = kubernetes_namespace.ns.metadata.0.name

  resources = [
    "${path.module}/istio-configuration/authorization-policy.yaml"
  ]
}

resource "kustomization_resource" "istio_configuration" {
  for_each   = data.kustomization_overlay.istio_configuration.ids
  depends_on = [kubernetes_namespace.ns]

  manifest = data.kustomization_overlay.istio_configuration.manifests[each.value]
}