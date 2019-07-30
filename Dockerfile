FROM quay.io/jzbruno/terraform-provider-shell:v0.2.1-alpine-2 as TERRAFORM_SHELL_PROVIDER

FROM hashicorp/terraform:0.11.13

RUN apk add --update python py-pip openssl ca-certificates groff zip \
    && pip install awscli --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

RUN mv /root/.local/bin/aws /usr/bin/aws

RUN mkdir -p /root/.terraform.d/plugins/
COPY --from=TERRAFORM_SHELL_PROVIDER /terraform-provider-shell  /root/.terraform.d/plugins/terraform-provider-shell

ENTRYPOINT ["terraform"]