resource "local_file" "policy" {
  content = templatefile(
    "${path.module}/istio-configuration/authorization-policy.yaml.hcl",
    {
      namespace = kubernetes_namespace.ns.metadata.0.name
    }
  )
  filename = "${path.module}/istio-configuration/authorization-policy.yaml"
}

data "kustomization_build" "istio_configuration" {
  depends_on = [local_file.policy]

  path = "${path.module}/istio-configuration"
}

resource "kustomization_resource" "istio_configuration" {
  depends_on = [kubernetes_namespace.ns]

  for_each = data.kustomization_build.istio_configuration.ids
  manifest = data.kustomization_build.istio_configuration.manifests[each.value]
}