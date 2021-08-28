output "waiter" {
  value       = resource.kustomization_resource.istio_operator
  description = "A dummy output variable to enable other modules to 'depend_on' this module."
}