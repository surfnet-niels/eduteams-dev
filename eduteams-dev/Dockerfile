FROM debian

EXPOSE 22
EXPOSE 443

RUN apt update && apt full-upgrade && apt autoremove
RUN apt install -y openssh-server sudo python

RUN useradd -ms /bin/bash debian

RUN echo "debian ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENTRYPOINT service ssh start && /bin/bash
