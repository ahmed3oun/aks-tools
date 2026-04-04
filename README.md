# aks-tools

A Terraform-based toolkit for configuring Azure Kubernetes Service (AKS) infrastructure and Kubernetes platform services.

This project manages AKS integration with:
- **cert-manager** for automated TLS certificate issuance
- **Envoy Proxy** + **Gateway API** for application ingress and HTTP/HTTPS routing
- **ExternalDNS** for DNS management
- **KEDA** for Kubernetes event-driven autoscaling
- **Application microservice manifests** deployed via `kubectl_manifest`

## Features

- Provision infrastructure resources in AKS using Terraform providers for `azurerm`, `kubernetes`, `helm`, and `kubectl`
- Deploy custom Kubernetes manifests for gateway, microservices, and scaling configuration
- Support HTTPS termination with Gateway API and cert-manager-managed certificates
- Integrate ExternalDNS for dynamic DNS record management
- Enable KEDA autoscaling for workloads based on metrics or external events

## Project structure

- `backend.tf` - Terraform backend configuration
- `providers.tf` - Azure, Kubernetes, Helm, and kubectl provider setup
- `variables.tf` - Input variables for cluster name, resource group, and other settings
- `locals.tf` - Local values used across Terraform modules
- `cert-manager.tf` - cert-manager Helm deployment configuration
- `certificates.tf` - TLS certificate definitions and issuer setup
- `envoy_proxy_gateway.tf` - Envoy Proxy gateway infrastructure configuration
- `external-dns.tf` - ExternalDNS configuration for dynamic DNS management
- `gateway.tf` - Kubernetes Gateway and route integration
- `keda.tf` - KEDA autoscaling configuration
- `microservices.tf` - Deployment of application microservice manifests via `kubectl_manifest`
- `kubernetes/` - Kubernetes manifests and Helm chart values used by this project

## Prerequisites

- Azure subscription with an existing AKS cluster
- Terraform 1.14 or later
- `kubectl` configured for the target cluster, or valid cluster credentials in Terraform variables
- Azure credentials available in environment or Terraform provider configuration

## Usage

1. Update Terraform variables in `variables.tf` or pass them via CLI:
   - `cluster_name`
   - `rg_name`
   - Any other required values for your AKS environment

2. Initialize Terraform:

```bash
terraform init
```

3. Review the planned changes:

```bash
terraform plan
```

4. Apply the configuration:

```bash
terraform apply
```

5. Verify the deployed Kubernetes resources in the AKS cluster:

```bash
kubectl get all --all-namespaces
```

## Customization

- Edit `kubernetes/helm/cert-manager/values.yml` to adjust cert-manager behavior
- Modify `kubernetes/manifests/gateway.yml` to change gateway listeners, hostname, and TLS settings
- Update `kubernetes/manifests/microservices/*.yml` for application deployment changes
- Adjust `kubernetes/helm/keda/values.yml` to tune autoscaling policies

## Notes

- The project is intended to manage cluster-integrated platform services rather than provision the AKS cluster itself.
- The current gateway manifest is configured for a specific hostname under `hostname: ahmedoun.aks.karimarous.com`; update this to match your environment.

## License

Specify your preferred license here.
