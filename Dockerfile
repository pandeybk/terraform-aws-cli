FROM hashicorp/terraform:0.12.5

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    && pip install awscli --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

RUN mv /root/.local/bin/aws /usr/bin/aws

ENTRYPOINT ["sh", "-c"]
CMD ["terraform"]