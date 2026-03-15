resource "kubernetes_namespace" "keda" {
  metadata {
    name = "keda"
  }
}

resource "helm_release" "keda" {
  name       = "keda"
  namespace  = kubernetes_namespace.keda.metadata[0].name
  chart      = "keda"
  repository = "https://kedacore.github.io/charts"
  version    = "2.19.0" # Specify the desired version

  values     = [file("${path.module}/kubernetes/helm/keda/values.yaml")]
  depends_on = [kubernetes_namespace.keda]
}


# explain this file in detail
# This file defines the infrastructure for deploying KEDA (Kubernetes Event-Driven Autoscaling) 
# in a Kubernetes cluster using Terraform. It includes the creation of a Kubernetes namespace for 
# KEDA, and the installation of KEDA using Helm. The Helm release is configured to use a specific 
# version of KEDA, and the values for the Helm chart are provided from a YAML file.
# The resources are defined with dependencies to ensure that they are created in the correct order,
# with the namespace being created before the Helm release. This setup enables the deployment of KEDA 
# in the Kubernetes cluster, allowing for event-driven autoscaling of applications based on various
# metrics and events, improving the efficiency and responsiveness of the applications running in the cluster.