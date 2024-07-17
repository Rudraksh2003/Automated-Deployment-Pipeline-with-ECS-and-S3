# Automated-Deployment-Pipeline-with-ECS-and-S3

This project combines the functionality of an S3 build pipeline and a builder server to automate the deployment of applications using AWS services. The setup leverages AWS ECS, ECR, and task definitions to automatically save application builds to S3 and deploy them properly.

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [Clone Repository](#clone-repository)
  - [Build Docker Image](#build-docker-image)
  - [Push Docker Image to ECR](#push-docker-image-to-ecr)
  - [Create ECS Task Definition](#create-ecs-task-definition)
  - [Run ECS Task](#run-ecs-task)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

The goal of this project is to automate the build and deployment process of applications. It utilizes a GitHub repository link provided in an ECS task definition to trigger the build process. The built artifacts are then saved to an S3 bucket, and the application is deployed using AWS ECS.

## Architecture

1. **GitHub Repository**: Source code repository containing the application.
2. **Docker**: Used to containerize the application.
3. **AWS ECR (Elastic Container Registry)**: Stores Docker images.
4. **AWS ECS (Elastic Container Service)**: Manages and runs Docker containers.
5. **AWS S3 (Simple Storage Service)**: Stores build artifacts.
6. **Builder Server**: Executes build scripts and interacts with AWS services.

## Prerequisites

- AWS account with necessary permissions
- Docker installed
- AWS CLI configured
- GitHub repository with application code
- Node.js installed for the build process

## Setup

### Clone Repository

```sh
git clone <your-github-repo-url>
cd <your-repo-directory>
```

### Build Docker Image

```sh
docker build -t builder-server .
```

### Push Docker Image to ECR

1. Authenticate Docker to ECR:

```sh
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

2. Tag the Docker image:

```sh
docker tag builder-server:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/builder-server:latest
```

3. Push the Docker image:

```sh
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/builder-server:latest
```

### Create ECS Task Definition

Create a new task definition in AWS ECS with the following configuration:
- Container image: `<your-account-id>.dkr.ecr.<your-region>.amazonaws.com/builder-server:latest`
- Environment variables:
  - `GIT_REPOSITORY__URL`: URL of your GitHub repository
  - `PROJECT_ID`: Unique identifier for the project

### Run ECS Task

Run the ECS task using the created task definition. This will trigger the build process, save the artifacts to S3, and deploy the application.

## Usage

1. Push code changes to the GitHub repository.
2. The ECS task automatically detects the changes, builds the application, and uploads the artifacts to S3.
3. The built application is deployed using AWS ECS.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

