FROM ubuntu:16.04

EXPOSE 80
EXPOSE 443

RUN apt -y update && apt -y full-upgrade && apt -y autoremove && apt install -y --no-install-recommends sudo dnsutils git software-properties-common vim
RUN apt-add-repository -y ppa:ansible/ansible && apt -y update && apt install -y ansible
RUN apt -y clean

# RUN git clone https://github.com/surfnet-niels/simplesaml-idp.git /tmp/ansible/simplesaml-idp
COPY simplesaml-client /tmp/ansible
# COPY config/ansible/inventory /tmp/ansible/
# COPY config/ansible/client.yml /tmp/ansible/group_vars/

RUN ansible-playbook -i /tmp/ansible/inventory /tmp/ansible/simplesaml-client.yml

# COPY config/metadata /var/www/simplesamlphp/metadata

ENTRYPOINT service apache2 start && /bin/bash
# ENTRYPOINT /bin/bash
