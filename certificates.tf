resource "kubectl_manifest" "certificate_app" {
  yaml_body  = file("${path.root}/kubernetes/helm/cert-manager/manifests/app-certificate.yml")
  depends_on = [kubectl_manifest.cluster_issuer]
}

# explain this file

