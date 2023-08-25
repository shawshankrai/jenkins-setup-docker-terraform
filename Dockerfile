FROM google/cloud-sdk

USER root

RUN apt-get update \
	&& apt-get install -y curl wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
	rm -rf /terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /home

VOLUME $HOME:/home



