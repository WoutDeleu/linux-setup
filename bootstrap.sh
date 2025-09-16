#!/usr/bin/env bash
set -e

sudo dnf install -y ansible git stow

# clone repo if missing
if [ ! -d ~/my-setup ]; then
  git clone https://github.com/WoutDeleu/linux-setup ~/linux-setup
fi

cd ~/linux-setup/ansible
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass
