FROM debian:buster-slim AS artifacts-image

LABEL maintainer="Victor GRENU - https://github.com/z0ph/"
LABEL Project="https://github.com/z0ph/aws-security-toolbox"

WORKDIR /opt/tmp

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    jq \
    curl \
    awscli \
    wget 

RUN mkdir -p \
    /opt/artifacts/prowler \
    /opt/artifacts/scoutesuite \
    /opt/artifacts/cloudmapper \
    /opt/artifacts/cloudtracker \
    /opt/artifacts/enumerate-iam \
    /opt/artifacts/policy_sentry \
    /opt/artifacts/principalmapper \
    /opt/artifacts/parliament

# prowler
RUN curl -sk https://api.github.com/repos/toniblyx/prowler/releases \
    | grep tarball_url \
    | head -n 1 \
    | cut -d '"' -f 4 \
    | wget -q -O /opt/tmp/prowler.tar.gz --no-check-certificate -i - && \
    tar -xz -C /opt/artifacts/prowler -f /opt/tmp/prowler.tar.gz --strip 1 && \
    rm -f /opt/tmp/prowler.tar.gz
#####################################################

# ScouteSuite
RUN curl -sk https://api.github.com/repos/nccgroup/ScoutSuite/releases \
    | grep tarball_url \
    | head -n 1 \
    | cut -d '"' -f 4 \
    | wget -q -O /opt/tmp/scoutesuite.tar.gz --no-check-certificate -i - && \
    tar -xz -C /opt/artifacts/scoutesuite -f /opt/tmp/scoutesuite.tar.gz --strip 1 && \
    rm -f /opt/tmp/scoutesuite.tar.gz
######################################################

# CloudMapper
# RUN curl -sk https://api.github.com/repos/duo-labs/cloudmapper/releases \
#     | grep tarball_url \
#     | head -n 1 \
#     | cut -d '"' -f 4 \
#     | wget -q -O /opt/tmp/cloudmapper.tar.gz --no-check-certificate -i -

# RUN tar -xz -C /opt/artifacts/cloudmapper -f /opt/tmp/cloudmapper.tar.gz --strip 1 && \
#     rm -f /opt/tmp/cloudmapper.tar.gz
######################################################

# CloudTracker
# RUN curl -sk https://api.github.com/repos/duo-labs/cloudtracker/releases \
#     | grep tarball_url \
#     | head -n 1 \
#     | cut -d '"' -f 4 \
#     | wget -q -O /opt/tmp/cloudtracker.tar.gz --no-check-certificate -i -

# RUN tar -xz -C /opt/artifacts/cloudtracker -f /opt/tmp/cloudtracker.tar.gz --strip 1 && \
#     rm -f /opt/tmp/cloudtracker.tar.gz
######################################################

# Enumerate IAM
# RUN curl -sk https://api.github.com/repos/andresriancho/enumerate-iam/releases \
#     | grep tarball_url \
#     | head -n 1 \
#     | cut -d '"' -f 4 \
#     | wget -q -O /opt/tmp/enumerate-iam.tar.gz --no-check-certificate -i -

# RUN tar -xz -C /opt/artifacts/enumerate-iam -f /opt/tmp/enumerate-iam.tar.gz --strip 1 && \
#     rm -f /opt/tmp/enumerate-iam.tar.gz
######################################################


# FROM python:3.7-slim AS aws-sec-toolbox
# COPY --from=artifacts-image /opt/artifacts /opt/secops

# RUN pip --no-cache-dir install \
#         pipenv \
#         ansi2html \
#         detect-secrets \
#         boto3 \
#         awscli
#         # principalmapper \
#         # policy_sentry

# RUN apt-get update -y && \
#     apt-get install --no-install-recommends -y \
#     bash \
#     build-essential \
#     autoconf \
#     automake \
#     libtool \
#     python3.7-dev \
#     python3-tk \
#     jq \
#     curl \
#     wget \
#     file \
#     netcat