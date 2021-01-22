# TitanicAI

## Solution Components

- *AI model:* trained & build with R Code
- *API:* serves the AI model via HTTP protocol
- *Webapp:* serves as a front end for the TitanicAI R Model

**TitanicAI** is 100% built on *Docker Containers*, therefore as a minimum, all you need on your local workstation to be able to run the code in this GitHub repository is [Docker Installation](https://docs.docker.com/get-docker/).

## Solution Overview

|Folder|Description|
|-----|-----|
|.cicd|Automation scripts and declarations for *Azure DevOps*, *Jekyll*, *Dockerfiles*, *Docker Compose*, *Kubernetes* and *Helm*.<br />- ado: Azure DevOps Build Yaml Declarations<br />- compose: Docker Compose Yaml Declarations<br />- docker: Dockerfiles<br />- helm: Helm Chart Yaml Declarations<br />- jekyll: Jekyll GutHub Pages Declarations<br />- kubernetes: Kubernetes Yaml Declarations|
|docs|Documentation regarding CICD, source code and running the code locally.|
|run|Scripts for running the code locally.|
|src|Source code for the R *model* and the ASPNET *webapp*.<br />- model: R Code<br />- webapp: ASPNET C# Web application|

## Working with R Studio

> [TitanicAI Studio](docs/studio.md) documentation.

## Working with R Api

> [TitanicAI Api](docs/api.md) documentation.

## Working with Webapp

> [TitanicAI Webapp](docs/webapp.md) documentation.

## Running Solution Locally

> [TitanicAI Run](docs/run.md) documentation.

## Deploying Solution

> [TitanicAI CICD](docs/cicd.md) documentation.

## External Resources

- [TitanicAI Demo Application](https://demo.titanicai.dev)
- [TitanicAI DockerHub Api Image](https://hub.docker.com/repository/docker/qbituniverse/titanicai-api)
- [TitanicAI DockerHub Webapp Image](https://hub.docker.com/repository/docker/qbituniverse/titanicai-webapp)