resource "helm_release" "istio_control_plane" {
  atomic     = true
  chart      = "control-plane"
  lint       = true
  name       = "istio-control-plane"
  repository = "${path.module}/charts"

  set {
    name  = "ingressGateway.ip.resourceGroup"
    value = var.ingress_gateway.ip.resource_group
  }

  set {
    name  = "ingressGateway.ip.value"
    value = var.ingress_gateway.ip.value
  }
}