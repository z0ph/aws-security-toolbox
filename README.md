# AWS Security Toolbox

This toolbox will bring to you all necessary apps as a Docker container for SecOps on AWS, especially for auditing purpose.

## Requirements

- docker

## Tools

## Optional tools (host machine)

- aws-vault

### Tools (guest container)

- awscli
- CloudMapper
- CloudTracker
- prowler
- ScoutSuite
- PMapper

## Usage

```bash
git clone https://github.com/z0ph/aws-security-toolbox.git

make run
```

```bash
docker exec -it -v $HOME/.aws:/root/.aws:ro z0ph/aws-sec-toolbox:latest bash
docker run -it z0ph/aws-sec-toolbox:latest /bin/bash
```

# Ref
- https://hub.docker.com/r/toniblyx/prowler/dockerfile
- https://ryanparman.com/posts/2019/running-aws-vault-with-local-docker-containers/