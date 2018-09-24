FROM debian

EXPOSE 22
EXPOSE 443

RUN apt update && apt full-upgrade && apt autoremove
RUN apt install -y openssh-server git

RUN useradd -ms /bin/bash debian

RUN mkdir -p /home/debian/.ssh/

COPY config/id_rsa.pub /home/debian/.ssh
RUN cat /home/debian/.ssh/id_rsa.pub > /home/debian/.ssh/authorized_keys

RUN chown -Rf debian. /home/debian/
RUN chmod -Rf 700 /home/debian/.ssh 
 
ENTRYPOINT service ssh start && /bin/bash
