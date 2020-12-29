FROM alpine:latest

ENV TERRAFORM_VERSION=0.14.3
ENV TERRAFORM_PROVIDER_KUBERNETES=1.13.3

RUN apk add --update bash curl openssl

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./

RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN ["addgroup", "-S", "myuser"]
RUN ["adduser", "-S", "-D", "-h", "/home/myuser", "-G", "myuser", "myuser"]
RUN ["mkdir", "-p", "/home/myuser/terraform.d/plugins/linux_amd64/"]

ADD https://releases.hashicorp.com/terraform-provider-kubernetes/${TERRAFORM_PROVIDER_KUBERNETES}/terraform-provider-kubernetes_${TERRAFORM_PROVIDER_KUBERNETES}_linux_amd64.zip ./
RUN unzip terraform-provider-kubernetes_${TERRAFORM_PROVIDER_KUBERNETES}_linux_amd64.zip
RUN cp terraform-provider-kubernetes_v${TERRAFORM_PROVIDER_KUBERNETES}_x4 /home/myuser/terraform.d/plugins/linux_amd64/terraform-provider-kubernetes_v${TERRAFORM_PROVIDER_KUBERNETES}_x4
RUN rm -f terraform-provider-kubernetes_${TERRAFORM_PROVIDER_KUBERNETES}_linux_amd64.zip

RUN chown myuser:myuser -R /home/myuser
RUN chmod +x -R /home/myuser/terraform.d/plugins/linux_amd64/
USER myuser
WORKDIR /home/myuser/