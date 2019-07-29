FROM golang:alpine

ENV TERRAFORM_VERSION=0.11.13

RUN apk add --update \
    git \
    bash \
    openssh \
    python \
    python-dev \
    py-pip \
    build-base \
    && pip install awscli --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

RUN mv /root/.local/bin/aws /usr/bin/aws

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["terraform"]