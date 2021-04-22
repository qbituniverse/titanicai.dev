---
title: titanicai.dev
description: TitanicAI
permalink: /
---

> #### **TitanicAI** is built entirely on container technology with [Docker](https://www.docker.com). To be able to run the code from the [TitanicAI GitHub](https://github.com/qbituniverse/titanicai.dev) repository, all you need on your local workstation is [Docker Installation](https://docs.docker.com/get-docker/).

|Documentation|Packages|Showcase|
|-----|-----|-----|
|[Project Overview](/overview)|[DockerHub Api Image](https://hub.docker.com/repository/docker/qbituniverse/titanicai-api)|[Live Demo](https://demo.titanicai.dev)|
|[Project Description](/description)|[DockerHub Webapp Image](https://hub.docker.com/repository/docker/qbituniverse/titanicai-webapp)|[Gallery](/gallery)|
|[R Model Code Overview](/model)|||
|[C# Webapp Code Overview](/webapp)|||
|[Development Process](/development)|||
|[Deployment Process](/deployment)|||

> ### Try TitanicAI Now

> #### Option 1: Docker Compose

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

Then use the commands below to start **TitanicAI** up and use it.

```bash
# start up TitanicAI
docker-compose up

# TitanicAI Webapp
start http://localhost:8010

# TitanicAI Api docs
start http://localhost:8011/__docs__/

# finish and clean up TitanicAI
docker-compose down
```

> #### Option 2: Docker Run

Alternatively, you can run **TitanicAI** without compose, just simply use docker commands below.

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

# TitanicAI Webapp
start http://localhost:8010

# TitanicAI Api docs
start http://localhost:8011/__docs__/

# finish and clean up TitanicAI
docker rm -fv titanicai-api
docker volume rm -f titanicai-api
docker rm -fv titanicai-webapp
docker volume rm -f titanicai-webapp
docker network rm titanicai-bridge
```