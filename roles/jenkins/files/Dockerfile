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
ENV KEYS_DIR=/var/githubkeys
RUN mkdir -p $KEYS_DIR/ && chmod 700 $KEYS_DIR/
COPY id_rsa* $KEYS_DIR/
RUN chmod 400 $KEYS_DIR/* && chown jenkins -R $KEYS_DIR
COPY ssh_config /etc/ssh/ssh_config
USER jenkins

