#############################################################################
# TitanicAI App - Kubernetes
#############################################################################
# set context
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context

# deploy
kubectl apply -f .cicd/kubernetes/deploy.yaml

# check deployment
kubectl get all -n titanicai

# launch webapp & api
start http://localhost:8010
start http://localhost:8011/api/ping

# clean-up
kubectl delete namespace titanicai