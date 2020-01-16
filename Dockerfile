FROM python:3.7-slim as aws-sec-toolbox

LABEL maintainer="Victor GRENU - https://github.com/z0ph/"
LABEL Project="https://github.com/z0ph/aws-security-toolbox"

WORKDIR /opt/secops

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    bash \
    build-essential \
    autoconf \
    automake \
    libtool \
    python3.7-dev \
    python3-tk \
    jq \
    vim \
    curl \
    file \
    netcat \
    git

RUN pip --no-cache-dir install \
        pipenv \
        ansi2html \
        detect-secrets \
        boto3 \
        awscli \
        cloudtracker \
        scoutsuite \
        principalmapper

# CloudMapper
RUN git clone https://github.com/duo-labs/cloudmapper.git /opt/secops/cloudmapper && \
        cd /opt/secops/cloudmapper && \
        pipenv install --skip-lock

# Enumerate IAM
RUN git clone https://github.com/andresriancho/enumerate-iam.git /opt/secops/enumerate-iam && \
    cd /opt/secops/enumerate-iam/ && \
    pip install -r requirements.txt

# prowler
RUN git clone https://github.com/toniblyx/prowler /opt/secops/prowler