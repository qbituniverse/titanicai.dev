---
title: Deployment Process
description: Deployment Process
permalink: /deployment/
---

## Deployment Process

### Docker Compose

Location: **.cicd/compose** and **.cicd/cicd-compose.sh**

#### Start up with Docker Compose

```bash
# using GitHub local source code
docker-compose -f .cicd/compose/docker-compose.GitHub.yaml up

# using DockerHub image repository
docker-compose -f .cicd/compose/docker-compose.DockerHub.yaml up
```

#### Launch

```bash
start http://localhost:8010
```

#### Take Down with Docker Compose

```bash
# using GitHub local source code
docker-compose -f .cicd/compose/docker-compose.GitHub.yaml down

# using DockerHub image repository
docker-compose -f .cicd/compose/docker-compose.DockerHub.yaml down
```

### Kubernetes

Location: **.cicd/kubernetes** and **.cicd/cicd-kubernetes.sh**

#### Configure Kubernetes Context

```bash
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context
```

#### Deploy to Kubernetes

```bash
# deploy
kubectl apply -f .cicd/kubernetes/deploy.yaml

# check deployment
kubectl get all -n titanicai
```

#### Launch

```bash
start http://localhost:8010
```

#### Take Down from Kubernetes

```bash
kubectl delete namespace titanicai
```

### Helm

Location: **.cicd/helm** and **.cicd/cicd-helm.sh**

#### Configure Kubernetes Context

```bash
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context
```

#### Deploy to Kubernetes with Helm

```bash
# deploy webapp & api
helm upgrade titanicai-webapp -i --create-namespace --namespace titanicai .cicd/helm/titanicai-webapp
helm upgrade titanicai-api -i --create-namespace --namespace titanicai .cicd/helm/titanicai-api

# deploy ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx \
--namespace titanicai \
--set controller.replicaCount=1 \
--set controller.admissionWebhooks.enabled=false \
--set controller.service.externalTrafficPolicy=Local

# check deployments
kubectl get all -n titanicai
kubectl get ingress -n titanicai
helm list --all -n titanicai
```

#### Launch

```bash
start http://web.titanicai.localhost
start http://api.titanicai.localhost
```

#### Take Down from Kubernetes

```bash
kubectl delete namespace titanicai
```