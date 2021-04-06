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
|**docs**|Soluion documentation files, refer to **Documentation** section below for further details.|
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