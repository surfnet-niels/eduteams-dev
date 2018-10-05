FROM debian

EXPOSE 22
EXPOSE 443

RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo git openssh-server python vim gpg software-properties-common dirmngr
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
RUN apt -y update
RUN apt install -y ansible

RUN useradd -ms /bin/bash debian
COPY config/ssh/id_rsa /root/.ssh/id_rsa
COPY config/sshconfig /root/.ssh/config
# COPY config/ssh/id_rsa.pub /home/debian/.ssh/authorized_keys

RUN echo "debian ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN git clone -b feature-docker-deploy git@dev.niif.hu:vopaas/TEIP-deploy.git /var/eduteams/TEIP-deploy
RUN echo "foobar" > /var/eduteams/TEIP-deploy/.docker_vault_pass
RUN cd /var/eduteams/TEIP-deploy && ./docker-deploy.sh

ENTRYPOINT /bin/bash
#ENTRYPOINT service ssh start && /bin/bash
#ENTRYPOINT /home/debian/vopaas/bin/docker-run.sh && /bin/bash
