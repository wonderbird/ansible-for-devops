# Adopted from https://circleci.com/blog/ssh-into-docker-container/
FROM ubuntu:24.10

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Setup the SSH server for user "vagrant", which is used by Vagrant by default.
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && useradd -m -s /bin/bash vagrant

COPY ./id_ecdsa.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 700 /home/vagrant/.ssh \
    && chmod 600 /home/vagrant/.ssh/authorized_keys \
    && chown -R vagrant:vagrant /home/vagrant/.ssh

EXPOSE 22

ENTRYPOINT service ssh start && bash -c "tail -f /dev/null"