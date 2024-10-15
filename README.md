# Fullstack application utilizing Terraform for infrastructure provisioning and Kubernetes for container orchestration

## Architecture

![architecture](infrastructure/environments/dev//k8s/chart/architecture.png)

## Deployment

_Build_

1. [Deploy infrastructure](.github/workflows/dev-deploy-infra.yaml)
2. Build and publish application artifacts ([Backend](.github/workflows/dev-build-backend.yaml), [Frontend](.github/workflows/dev-build-frontend.yaml))
3. [Deploy Kubernetes resources](.github/workflows/dev-deploy-application.yaml)

_Tear down_

1. Remove Kubernetes resources
2. Remove Ingress
3. [Destroy infrastructure](.github/workflows/dev-destroy-infra.yaml)
4. Remove images from ECR
