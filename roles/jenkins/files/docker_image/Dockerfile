FROM jenkins/jenkins:latest

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# don't run setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# create admin user
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
COPY admin-user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home

# ssh access to git
USER root
COPY ssh_config /etc/ssh/ssh_config

# Docker client
RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-19.03.1.tgz |tar xzvf - --strip=1 -C /usr/local/bin docker/docker && groupadd docker -g 999 && usermod -a -G docker jenkins

# Ansible module
RUN curl https://bootstrap.pypa.io/get-pip.py |python && pip install ansible

USER jenkins

