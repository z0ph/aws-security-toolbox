FROM python:3.7-slim as aws-sec-toolbox

LABEL maintainer="https://github.com/z0ph/"
LABEL Project="https://github.com/z0ph/aws-security-toolbox"

WORKDIR /opt/secops
ENV AWS_DEFAULT_REGION=eu-west-1

RUN apt-get update -y
RUN apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    python3.7-dev \
    python3-tk \
    jq \
    htop \
    nc \
    awscli

COPY entrypoint.sh /opt/cloudmapper/entrypoint.sh

# Install the python libraries needed for CloudMapper
RUN pip install pipenv
RUN cd /opt/cloudmapper && pipenv install --skip-lock

ENTRYPOINT pipenv run /opt/cloudmapper/entrypoint.sh

# Handle the bash job
COPY script-fargate.sh /app/script.sh
RUN chmod +x /app/script.sh

CMD ["bash", "script.sh"]