# Usage
## Terraform
Install Terraform
Go to terraform dir:
terraform init
terraform apply
Try to connect to created machines (take ips from output, username: ubuntu) to pass key check (if you don't want - set ANSIBLE_HOST_KEY_CHECKING to False)
## Ansible
Go to ansible dir
Create virtuelenv
pip install -r requirements.txt
ansible-galaxy collection install -r collections/requirements.yaml
Change ips in inventory.yaml
ansible-playbook -i inventory.yaml playbook.yaml
Postgres with streaming replication should be set up.

## Destroy
Go to terraform dir
terraform destroy