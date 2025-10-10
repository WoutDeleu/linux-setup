#!/usr/bin/env bash
set -e

# Install required packages (change package manager command if needed)
sudo dnf install -y ansible git stow

# Clone repository if not present
if [ ! -d ~/linux-setup ]; then
  git clone https://github.com/WoutDeleu/linux-setup ~/linux-setup
fi

# Run Ansible playbook
cd ~/linux-setup/ansible
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass
