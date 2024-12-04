# Nokia SROS Firmware upgrade launchpad

## PreReqs

Ansible or ansible-core

## Installation

ansible-galaxy install -r collections/requirements.yaml

## Run

### Prepare hosts and variables

1. Edit `hosts` to add/edit devices

```ini
ansible_username=<USERNAME_HERE>
ansible_password=<PASSWORD_HERE>
# This below is optional, and only for old images with weak encryption
#ansible_ssh_common_args="-oHostKeyAlgorithms=+ssh-rsa"
```

2. Populate `localvars.yaml` file

```yaml
# Running SW version 
current_sw: B-21.10.R1
# URL with software package
remote_url: http://172.23.3.24:8080/NOKIA7750.SW
# Firmware filename
fw_filename: NOKIA7750.SW
# Nokia directory to download FW to
target_dir: newsw
# Hosts to run playbook on
hosts_to_run: sites
```

### Run playbook

```bash
ansible-playbook -i hosts pb.upgrade.yml -e "@localvars.yaml"
```

or

```bash
make run 
```