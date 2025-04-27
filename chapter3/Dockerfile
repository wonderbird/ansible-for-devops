# Adopted from https://circleci.com/blog/ssh-into-docker-container/
FROM ubuntu:24.10

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    openssh-server \
    python3 \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Ensure that the SSH server has a consistent host key.
COPY ./ssh_host_keys/* /etc/ssh/
RUN chmod 600 /etc/ssh/*_key \
    && chmod 644 /etc/ssh/*_key.pub

# Setup the SSH server for user "vagrant", which is used by Vagrant by default.
# Then add the vagrant user to the sudo group.
# and allow sudo without password.
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && useradd -m -s /bin/bash vagrant \
    && usermod -aG sudo vagrant \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY ./ssh_user_key/id_ecdsa.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 700 /home/vagrant/.ssh \
    && chmod 600 /home/vagrant/.ssh/authorized_keys \
    && chown -R vagrant:vagrant /home/vagrant/.ssh

EXPOSE 22

ENTRYPOINT service ssh start && bash -c "tail -f /dev/null"