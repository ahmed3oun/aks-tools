resource "kubernetes_namespace" "envoy_gateway_system" {
  metadata {
    name = "envoy-gateway-system"
  }
}

resource "helm_release" "envoy_proxy_gateway" {
  name      = "epg"
  namespace = kubernetes_namespace.envoy_gateway_system.metadata[0].name
  chart     = "oci://docker.io/envoyproxy/gateway-helm"
  version   = "1.7.0"

  values     = [file("${path.module}/kubernetes/helm/envoy-proxy-gateway/values.yaml")]
  depends_on = [kubernetes_namespace.envoy_gateway_system]
}

resource "kubectl_manifest" "envoy_proxy" {
  yaml_body  = file("${path.root}/kubernetes/helm/envoy-proxy-gateway/manifests/envoyproxy.yaml")
  depends_on = [helm_release.envoy_proxy_gateway]
}

# explain this file in detail
# This file defines the infrastructure for deploying the Envoy Proxy Gateway in a Kubernetes cluster
# using Terraform. It includes the creation of a Kubernetes namespace for the gateway, 
# the installation of the Envoy Proxy Gateway using Helm, and the application of a manifest for the 
# Envoy Proxy custom resource. The Helm release is configured to use a specific version of 
# the Envoy Proxy Gateway chart, and the manifest defines the desired state of the gateway deployment,
# including logging settings, provider specifications for Kubernetes, and resource management parameters
# such as horizontal pod autoscaling (HPA) for the Envoy deployment. The HPA is configured to 
# scale the number of replicas based on CPU utilization, ensuring that the gateway can handle varying 
# levels of traffic while maintaining performance and reliability. The service type is set to LoadBalancer,
# which allows the gateway to be exposed externally, and the external traffic policy is set to 
# Cluster to preserve client IPs for better logging and security. 
# This setup enables the deployment of a robust and scalable API gateway in the Kubernetes cluster,
# facilitating secure and efficient communication between services.
