# Prerequisites and Example Solutions for the Ansible for DevOps Book

Chapter by chapter I provide my version of prerequisites and supplementary
material, so that one can follow along with the examples in the Ansible for
DevOps book.

## Vagrant Stack with Tart Provider

Chapter 2 uses the Tart provider for Vagrant. Thus, a separate
[Vagrantfile](./chapter2/Vagrantfile) is provided.

## Vagrant Stack with Docker Provider

### About the Stack

At the time of writing, the Tart provider did not support multiple machines.
Thus, starting with chapter 3, the Vagrant stack uses the Docker provider
instead. The [Vagrantfile](./Vagrantfile), [ansible.cfg](./ansible.cfg) and
[hosts.ini](./hosts.ini) in the root directory of this repository use that
setup.

If some of the subdirectories contain a separate Vagrantfile, ansible.cfg and
hosts.ini, then these files are used instead for the exercise instead of the
ones in the root directory.

The Dockerfiles located in this directory provide Ubuntu, Fedora and Rocky Linux
servers with SSH access and systemd.

The key pair `id_ecdsa*` was generated with the following command line without a
password (`-N ""`):

```shell
ssh-keygen -N "" -f ./id_ecdsa -t ecdsa -b 521 -C vagrant@localhost
```

It is automatically registered in the Docker container as the SSH key for the
`vagrant` user and is used by Ansible.

The host key is also predefined, so it remains the same even after changes to
the Dockerfile.

Configure the Dockerfile in the [Vagrantfile](./Vagrantfile).

### Starting the Stack

Before the first start, I recommend building the Docker image. This makes
Vagrant start faster.

```shell
docker build -t ansible-target -f Dockerfile.Fedora .
```

Then start the stack:

```shell
vagrant up
```

Ensure that the stack is running properly:

```shell
vagrant status
```

The three containers `app1`, `app2`, and `db1` should be shown with the status
`running (docker)`.

```shell
docker ps
```

The containers should be displayed with the status `Up`. The command that is
running corresponds to the systemd init process. Under Fedora, `/usr/sbin/init`
is shown, and under Ubuntu, `/lib/systemd/systemd`.

Next, the SSH host keys for the forwarded ports must be added to your own
`~/.ssh/known_hosts` file:

```shell
ssh -i ./ssh_user_key/id_ecdsa vagrant@localhost -p 2223 # app1
ssh -i ./ssh_user_key/id_ecdsa vagrant@localhost -p 2224 # app2
ssh -i ./ssh_user_key/id_ecdsa vagrant@localhost -p 2225 # db1
```

After that, the host mapping can be verified in Ansible:

```shell
ansible multi -a "hostname"
```

Expected output:

```text
app2 | CHANGED | rc=0 >>
app2
app1 | CHANGED | rc=0 >>
app1
db1 | CHANGED | rc=0 >>
db1
```

### Stopping and Destroying the Stack

Stop the stack:

```shell
vagrant halt
```

Destroy the stack:

```shell
vagrant destroy -f
```

The `-f` flag skips the confirmation prompt before deletion.

## Acknowledgements

This project uses code, documentation and ideas generated with the assistance of
 large language models.

## References

J. Geerling, _Ansible for DevOps_, 2nd ed. Leanpub, 2023. Accessed: Apr. 20,
2025. [Online].
Available: [https://www.ansiblefordevops.com/](https://www.ansiblefordevops.com/)

J. Geerling and GitHub Contributors, “geerlingguy/ansible-for-devops: Ansible
for DevOps examples.” Accessed: May 01, 2025. [Online].
Available: [https://github.com/geerlingguy/ansible-for-devops](https://github.com/geerlingguy/ansible-for-devops)
