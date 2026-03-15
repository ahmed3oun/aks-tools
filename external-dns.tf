/*
 resource "kubectl_manifest" "externaldns_sercret" {
  yaml_body = file("${path.root}/kubernetes/helm/external-dns/manifests/secret.yaml")
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  namespace  = "kube-system"
  chart      = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  version    = "1.20.0" # specify the desired version (omit leading "v" if the repo uses semver)

  values     = [file("${path.module}/kubernetes/helm/external-dns/values.yaml")]
  depends_on = [kubectl_manifest.externaldns_sercret]
}
*/


# explain this file in details:
# This Terraform configuration file is responsible for deploying the ExternalDNS application in a Kubernetes cluster using Helm. It consists of two main resources: `kubectl_manifest` and `helm_release`.
# 1. `kubectl_manifest` Resource:
#    - This resource is used to apply a Kubernetes manifest directly from a YAML file. In this case, it applies a secret manifest located at `${path.root}/kubernetes/helm/external-dns/manifests/secret.yaml`. This secret is likely required for ExternalDNS to authenticate with the DNS provider.
# 2. `helm_release` Resource:
#    - This resource manages the deployment of the ExternalDNS application using Helm. It specifies the name of the release (`external-dns`), the namespace where it will be deployed (`kube-system`), the Helm chart to use (`external-dns`), the repository where the chart is located (`https://kubernetes-sigs.github.io/external-dns`), and the version of the chart to deploy (`1.20.0`).
#    - The `values` attribute points to a YAML file that contains custom values for the Helm chart, allowing you to configure the ExternalDNS deployment according to your needs.
#    - The `depends_on` attribute ensures that the Helm release is not deployed until the secret manifest has been applied, ensuring that all necessary resources are in place before the application is deployed.
