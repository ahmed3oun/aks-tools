resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = "v1.19.0" # Specify the desired version
  values     = [file("${path.root}/kubernetes/helm/cert-manager/values.yaml")]
  depends_on = [kubernetes_namespace.cert_manager]
}

resource "kubectl_manifest" "cluster_issuer" {
  yaml_body  = file("${path.root}/kubernetes/helm/cert-manager/manifests/cluster-issuer.yaml")
  depends_on = [helm_release.cert_manager]
}

# explain this file in detail
# This file defines the infrastructure for deploying cert-manager in a Kubernetes cluster using Terraform.
# It includes the creation of a Kubernetes namespace for cert-manager, the installation of cert-manager 
# using Helm, and the application of a ClusterIssuer manifest for cert-manager to obtain TLS certificates 
# from Let's Encrypt. The Helm release is configured to use a specific version of cert-manager,
# and the ClusterIssuer is set up to use the ACME protocol with the HTTP-01 challenge type, 
# allowing for automatic certificate management. The resources are defined with dependencies to ensure 
# that they are created in the correct order, with the namespace being created before the Helm release,
# and the ClusterIssuer being applied after cert-manager is installed. This setup enables secure 
# communication for applications running in the Kubernetes cluster by automating the issuance and renewal 
# of TLS certificates.
