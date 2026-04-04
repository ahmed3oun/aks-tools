resource "kubectl_manifest" "gateway_class" {
  yaml_body  = file("${path.root}/kubernetes/manifests/gatewayclass.yml")
  depends_on = [kubectl_manifest.envoy_proxy]
}

resource "kubectl_manifest" "gateway" {
  yaml_body  = file("${path.root}/kubernetes/manifests/gateway.yml")
  depends_on = [ kubectl_manifest.http_route_app, kubectl_manifest.certificate_app, kubectl_manifest.gateway_class]
}
