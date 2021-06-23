data "kustomization_overlay" "istio_configuration" {
  for_each = local.manifests

  namespace = kubernetes_namespace.ns.metadata.0.name
  resources = [each.value]
}

resource "kustomization_resource" "istio_configuration" {
  for_each = {
    for m in local.kmanifests : m => m
  }

  manifest = each.value
}

locals {
  //   kmanifests = flatten([
  //     for overlay_key, overlay in data.kustomization_overlay.istio_configuration : [
  //       for id in overlay.ids : {
  //         manifest_id = "${overlay_key}${id}"
  //         manifest    = overlay.manifests[id]
  //       }
  //     ]
  //   ])

  kmanifests = flatten([
    for k, v in local.manifests : [
      for id in data.kustomization_overlay.istio_configuration[k].ids : {
        id = data.kustomization_overlay.istio_configuration[k].manifests[id]
      }
    ]
  ])


  manifests = {
    authn = "${path.module}/istio-configuration/authorization-policy.yaml"
  }
}

//   kmanifests = tolist(
//     flatten([
//       for key, path in local.manifests : [
//         for id in data.kustomization_overlay.istio_configuration[key].ids : {
//           id       = id
//           manifest = data.kustomization_overlay.istio_configuration[key].manifests[id]
//         }
//       ]
//   ]))