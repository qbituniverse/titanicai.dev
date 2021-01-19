#############################################################################
# TitanicAI App - Docker Compose
#############################################################################
# path
cd .cicd

####################################################################
# Option 1: Build Images from Local Sources
####################################################################
# start up
docker-compose -f docker/docker-compose.Build.yaml up

# launch webapp & api
start http://localhost:8010
start http://localhost:8011/api/ping

# clean-up
docker-compose -f docker/docker-compose.Build.yaml down


####################################################################
# Option 2: Pull Images from DockerHub
####################################################################
# start up
docker-compose -f docker/docker-compose.Pull.yaml up

# launch webapp & api
start http://localhost:8010
start http://localhost:8011/api/ping

# clean-up
docker-compose -f docker/docker-compose.Pull.yaml down