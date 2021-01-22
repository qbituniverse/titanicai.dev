#############################################################################
# TitanicAI App - Helm
#############################################################################
# set context
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context

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

# launch webapp & api
start http://web.titanicai.localhost
start http://api.titanicai.localhost/api/ping

# clean-up
kubectl delete namespace titanicai