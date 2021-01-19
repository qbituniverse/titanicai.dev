#############################################################################
# TitanicAI R Studio
#############################################################################
# path
cd source/model

# variables
dockerfile="Dockerfile-titanicai-studio"
image="qbituniverse/titanicai-studio:local"
container="titanicai-studio"


#############################################################################
# Create, configure and work with R Studio
#############################################################################
# build image
docker build -t $image -f .cicd/docker/$dockerfile .

# create container
docker run --name $container -d -p 8012:8787 -v $container:/home/rstudio -e DISABLE_AUTH=true $image

# launch R Studio
start http://localhost:8012


#############################################################################
# Container operations and pull sources down
#############################################################################
# start, stop, exec
docker start $container
docker stop $container
docker exec -it $container bash

# pull code from container
docker cp $container:/home/rstudio/code/. ./code/
docker cp $container:/home/rstudio/input/. ./input/
docker cp $container:/home/rstudio/output/. ./output/
docker cp $container:/home/rstudio/models/. ./models/


#############################################################################
# Clean-up
#############################################################################
docker rm -fv $container
docker volume rm -f $container
docker rmi -f $image