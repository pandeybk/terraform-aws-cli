FROM quay.io/jzbruno/terraform-provider-shell:v0.2.1-alpine-2 as TERRAFORM_SHELL_PROVIDER
FROM quay.io/jzbruno/terraform-provider-aws:v2.22.0-custom as TERRAFORM_AWS_PROVIDER

FROM hashicorp/terraform:0.11.13

RUN apk add --update python py-pip openssl ca-certificates groff zip jq \
    && pip install awscli --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/*

RUN mv /root/.local/bin/aws /usr/bin/aws

RUN mkdir -p /root/.terraform.d/plugins/
COPY --from=TERRAFORM_SHELL_PROVIDER /terraform-provider-shell  /root/.terraform.d/plugins/terraform-provider-shell
COPY --from=TERRAFORM_AWS_PROVIDER /terraform-provider-aws  /root/.terraform.d/plugins/terraform-provider-aws

ENTRYPOINT ["terraform"]