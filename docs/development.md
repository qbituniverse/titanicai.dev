---
title: Development Process
description: Development Process
permalink: /development/
---

> ## Development Process

> ### R Studio

Location: **run/run-rstudio.sh**

#### R Studio Variables

```bash
dockerfile="Dockerfile-titanicai-rstudio"
image="qbituniverse/titanicai-rstudio:local"
container="titanicai-rstudio"
```

#### Start R Studio

```bash
# build image
docker build -t $image -f .cicd/docker/$dockerfile .

# create container
docker run --name $container -d -p 8012:8787 -v $container:/home/rstudio -e DISABLE_AUTH=true $image

# launch R Studio
start http://localhost:8012
```

#### Pause and Restart R Studio

```bash
docker start $container
docker stop $container
docker exec -it $container bash
```

#### Pull Code Down from R Studio

```bash
docker cp $container:/home/rstudio/code/. ./src/model/code/
docker cp $container:/home/rstudio/input/. ./src/model/input/
docker cp $container:/home/rstudio/output/. ./src/model/output/
docker cp $container:/home/rstudio/models/. ./src/model/models/
```

#### Clean-up R Studio

```bash
docker rm -fv $container
docker volume rm -f $container
docker rmi -f $image
```

> ### R Api

Location: **run/run-rapi.sh**

#### R Api Variables

```bash
dockerfile="Dockerfile-titanicai-api"
image="qbituniverse/titanicai-api:local"
container="titanicai-api"
network="titanicai-bridge"
```

#### Start R Api

```bash
# build image
docker build -t $image -f .cicd/docker/$dockerfile .

# create network & container
docker network create $network
docker run --name $container -d -p 8011:8000 --network=$network $image

# test API
start http://localhost:8011/__docs__/
```

#### Pause and Restart R Api

```bash
docker start $container
docker stop $container
docker exec -it $container bash
```

#### Clean-up R Api

```bash
docker rm -fv $container
docker volume rm -f $container
docker rmi -f $image
docker network rm $network
```

> ### C# Webapp

Location: **run/run-webapp.sh**

#### C# Webapp Variables

```bash
dockerfile="Dockerfile-titanicai-webapp"
image="qbituniverse/titanicai-webapp:local"
container="titanicai-webapp"
network="titanicai-bridge"
```

#### Start C# Webapp

```bash
# build image
docker build -t $image -f .cicd/docker/$dockerfile .

# create network & container
docker network create $network
docker run --name $container -d -p 8010:80 --network=$network \
-e ASPNETCORE_ENVIRONMENT=Development \
-e WebApp__AiApi__BaseUri=http://titanicai-api:8000 \
$image

# launch Webapp
start http://localhost:8010
```

#### Pause and Restart C# Webapp

```bash
docker start $container
docker stop $container
docker exec -it $container bash
```

#### Clean-up C# Webapp

```bash
docker rm -fv $container
docker volume rm -f $container
docker rmi -f $image
docker network rm $network
```