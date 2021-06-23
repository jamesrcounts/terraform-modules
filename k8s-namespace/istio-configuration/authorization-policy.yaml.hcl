apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: allow-nothing
  namespace: ${namespace}
spec:
  action: ALLOW
  # the rules field is not specified, and the policy will never match.
---