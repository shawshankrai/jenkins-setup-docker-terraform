FROM jenkins/jenkins:latest

USER root

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# other settings
ENV TERRAFORM_VERSION=1.5.5
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# install Terraform
RUN apt-get update \
	&& apt-get install -y git curl wget \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin

# install jenkins plugins
COPY ./jenkins-plugins /usr/share/jenkins/plugins
RUN while read i ; \ 
		do jenkins-plugin-cli --plugins  $i ; \
	done < /usr/share/jenkins/plugins

# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

# volume for Jenkins settings
VOLUME /var/jenkins_home