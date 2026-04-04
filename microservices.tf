resource "kubectl_manifest" "deployment_app" {
  yaml_body  = file("${path.root}/kubernetes/manifests/microservices/app-deployment.yml")
}

resource "kubectl_manifest" "service_app" {
  yaml_body  = file("${path.root}/kubernetes/manifests/microservices/app-svc.yml")
}

resource "kubectl_manifest" "http_route_app" {
  yaml_body  = file("${path.root}/kubernetes/manifests/microservices/app-httproute.yml")
}

resource "kubectl_manifest" "scaledobject_app" {
  yaml_body  = file("${path.root}/kubernetes/helm/keda/manifests/app-scaledobject.yml")
}
