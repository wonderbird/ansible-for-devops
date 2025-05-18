# myapp

This is the sample application for chapter 3, "Deploy a version-controlled application".

## Prerequisites

### Git

`git` must be installed on the target machine.

```shell
ansible app -b -m package -a "name=git state=present"
```

### GitHub SSH Host Keys

The SSH host keys of GitHub must be added to the known hosts of the target machine.

```shell
# Copy the GitHub SSH host keys to a temporary file
ssh-keyscan -t ed25519,ecdsa-sha2-nistp256,rsa github.com > tmp_github_host_keys

# Compare the fingerprints of the keys to the known fingerprints present at
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
ssh-keygen -l -f tmp_github_host_keys

# After verifying the keys, copy them to the target machine
ansible app -b -m copy -a "src=tmp_github_host_keys dest=/root/.ssh/tmp_github_host_keys"

# Add the keys to the known_hosts file
ansible app -b -m shell -a "cat /root/.ssh/tmp_github_host_keys >> /root/.ssh/known_hosts"

# Verify the known_hosts file
ansible app -b -m shell -a "ssh-keygen -l -f /root/.ssh/known_hosts"

# Remove the temporary file
ansible app -b -m file -a "path=/root/.ssh/tmp_github_host_keys state=absent"
```

## Installation

To install or update the application, run the following commands:

```shell
# Clone or update the repository
ansible app -b -m git -a "repo=https://github.com/wonderbird/ansible-for-devops.git dest=/opt/ansible-for-devops update=yes version=main"

# Run the update.sh script from ./chapter3/myapp
ansible app -b -a "/bin/bash /opt/ansible-for-devops/chapter3/myapp/update.sh"
```
