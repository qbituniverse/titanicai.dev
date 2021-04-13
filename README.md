---
title: titanicai.dev
description: TitanicAI
permalink: /
---

**TitanicAI** is built entirely on container technology with [Docker](https://www.docker.com). Therefore, to be able to run the code from the [TitanicAI GitHub](https://github.com/qbituniverse/titanicai.dev) repository, all you need on your local workstation is [Docker Installation](https://docs.docker.com/get-docker/).

### Project Components

|Component|Description|
|-----|-----|
|**Model**|Model trained and built with **R Code** using **R Studio**. You can prepare the data, wrangle it, modify, visualise and run stats. There are many algorithms to choose from and many ways to parameterise your **AI training process**. You can also set criteria which model to choose for you final published API as well as ways to test accuracy of you chosen model.|
|**Api**|HTTP endpoint for your **trained AI model**. This project gives you an easy way to package your trained model (RDS file) and expose it via HTTP endpoint so that all you need to do from your client applications is to make an **API call** to the endpoint.|
|**Webapp**|Front end webapp for the **TitanicAI R Model**. To accompany this project, you can run an interactive website where you can pass different inputs (gender, class, siblings, etc.) to the AI model and get your **Titanic survival outcome** back.|

### Project Overview

|Folder|Description|
|-----|-----|
|**.cicd**|**ado**: Azure DevOps Build Yaml Declarations<br />**compose**: Docker Compose Yaml Declarations<br />**docker**: Dockerfiles<br />**helm**: Helm Chart Yaml Declarations<br />**kubernetes**: Kubernetes Yaml Declarations<br />**cicd-compose.sh**: deploy TitanicAI with Docker Compose<br />**cicd-helm.sh**: deploy TitanicAI with Helm<br />**cicd-kubernetes.sh**: deploy TitanicAI with Kubernetes|
|**docs**|Solution documentation files, refer to **Documentation** section below for further details.|
|**run**|**run-api.sh**: run Api locally<br />**run-rstudio.sh**: run R Studio locally<br />**run-webapp.sh**: run Webapp locally|
|**src**|**model**: R Code source code<br />**webapp**: ASPNET C# Web application source code|

### Project Resources

|Documentation|
|-----|
|[Project Description](/description)|
|[Project Showcase](/showcase)|
|[R Model Code Overview](/model)|
|[C# Webapp Code Overview](/webapp)|
|[Development Process](/development)|
|[Deployment Process](/deployment)|

|External Resources|
|-----|
|[DockerHub Api Image](https://hub.docker.com/repository/docker/qbituniverse/titanicai-api)|
|[DockerHub Webapp Image](https://hub.docker.com/repository/docker/qbituniverse/titanicai-webapp)|

### Try TitanicAI Now

You can get started with **TitanicAI** and see it in action in seconds.

#### Option 1: Docker Compose

Copy this YAML into a new **docker-compose.yaml** file on your file system.

```yaml
version: '3'
services:
  api:
    image: qbituniverse/titanicai-api:latest
    container_name: titanicai-api
    ports:
      - 8011:8000
    tty: true
    networks:
      - titanicai-bridge

  webapp:
    image: qbituniverse/titanicai-webapp:latest
    depends_on:
      - api
    container_name: titanicai-webapp
    environment:
      - ASPNETCORE_ENVIRONMENT=Development
      - WebApp__AiApi__BaseUri=http://titanicai-api:8000
    ports:
      - 8010:80
    tty: true
    networks:
      - titanicai-bridge

networks:
  titanicai-bridge:
    driver: bridge
```

Then run the commands below to start **TitanicAI** up and use it.

```bash
# start up TitanicAI
docker-compose up

# browse to TitanicAI Webapp
start http://localhost:8010

# TitanicAI Api endpoint URL
http://localhost:8011/api

# finish and clean up TitanicAI
docker-compose down
```

#### Option 2: Docker Run

Alternatively, you can run **TitanicAI** without compose, just simply run docker commands below.

```bash
# create network
docker network create titanicai-bridge

# start up TitanicAI containers
docker run --name titanicai-api -d -p 8011:8000 \
--network=titanicai-bridge qbituniverse/titanicai-api:latest

docker run --name titanicai-webapp -d -p 8010:80 \
-e ASPNETCORE_ENVIRONMENT=Development \
-e WebApp__AiApi__BaseUri=http://titanicai-api:8000 \
--network=titanicai-bridge qbituniverse/titanicai-webapp:latest

# browse to TitanicAI Webapp
start http://localhost:8010

# TitanicAI Api endpoint URL
http://localhost:8011/api

# finish and clean up TitanicAI
docker rm -fv titanicai-api
docker volume rm -f titanicai-api
docker rm -fv titanicai-webapp
docker volume rm -f titanicai-webapp
docker network rm titanicai-bridge
```