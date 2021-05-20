#############################################################################
# Setup Variables
#############################################################################
# GCP Project Name
$projectName = "<GCP PROJECT NAME>"

# Remaining Variables
$gkeName = "titanicai-demo"
$region = "europe-west2"
$zone = "europe-west2-a"
$kubernetesVersion = "1.19.8-gke.1600"
$kubernetesReleaseChannel = "None"
$nodesCount = "1"
$maxPods = "110"
$machineType = "custom-2-4096"
$machineImage = "COS"
$diskType = "pd-standard"
$diskSize = "32"
$ipAddressName = "titanicai-demo-ip"

#############################################################################
# Provision GCP Resources
#############################################################################
# Provision GKE
gcloud container clusters create $gkeName `
--project $projectName `
--zone $zone `
--node-locations $zone `
--no-enable-basic-auth `
--enable-shielded-nodes `
--cluster-version $kubernetesVersion `
--release-channel $kubernetesReleaseChannel `
--machine-type $machineType `
--image-type $machineImage `
--disk-type $diskType `
--disk-size $diskSize `
--metadata disable-legacy-endpoints=true `
--num-nodes $nodesCount `
--no-enable-stackdriver-kubernetes `
--enable-ip-alias `
--network "projects/$projectName/global/networks/default" `
--subnetwork "projects/$projectName/regions/$region/subnetworks/default" `
--default-max-pods-per-node $maxPods `
--no-enable-master-authorized-networks `
--addons HttpLoadBalancing `
--no-shielded-integrity-monitoring `
--quiet

# Provision Public IP Address
gcloud compute addresses create $ipAddressName `
--project $projectName `
--global `
--quiet

#############################################################################
# Configure DNS
#############################################################################
# Acquire Public IP Address
Write-Host "Your IP Address =>" `
(gcloud compute addresses describe $ipAddressName `
--project $projectName `
--global `
--format="value(address)")

# Configure DNS
# A Record => demo-gke => Your IP Address

#############################################################################
# Deploy Application in GKE
#############################################################################
# Get Credentials for GKE
gcloud container clusters get-credentials $gkeName `
--project $projectName `
--zone $zone

# Show Context Details
kubectl config get-contexts
kubectl config current-context

# Deploy Application to GKE
kubectl apply -f .cicd/gke/deploy-gke.yaml

# Check Deployments
kubectl get all -n titanicai-demo
kubectl get ingress -n titanicai-demo
kubectl get managedcertificate -n titanicai-demo

#############################################################################
# Clean-up
#############################################################################
# Delete GKE Deployments
kubectl delete namespace titanicai-demo

# Delete GCP Resources
gcloud container clusters delete $gkeName `
--project $projectName `
--zone $zone `
--quiet

gcloud compute addresses delete $ipAddressName `
--project $projectName `
--global `
--quiet

# Clear GKE Access Details
kubectl config delete-context gke_"$projectName"_"$zone"_"$gkeName"
kubectl config unset users.gke_"$projectName"_"$zone"_"$gkeName"
kubectl config unset contexts.gke_"$projectName"_"$zone"_"$gkeName"
kubectl config unset clusters.gke_"$projectName"_"$zone"_"$gkeName"