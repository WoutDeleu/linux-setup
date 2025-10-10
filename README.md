# Linux Setup

> Fast disaster recovery and new PC setup for Fedora i3 environments

Automates system setup using Ansible for packages, GNU Stow for dotfiles, and Ansible Vault for secrets.

## Prerequisites

- Fresh Linux installation (Fedora by default)
- Internet connection
- Sudo access

## Quick Start

```bash
# Download and run
curl -O https://raw.githubusercontent.com/WoutDeleu/linux-setup/main/bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

**For non-Fedora systems:** Edit line 5 of `bootstrap.sh` to change the package manager:
- Ubuntu/Debian: `sudo apt update && sudo apt install -y ansible git stow`
- Arch/Manjaro: `sudo pacman -Sy --noconfirm ansible git stow`
- openSUSE: `sudo zypper install -y ansible git stow`

## What It Does

1. Installs Ansible, Git, and Stow
2. Clones this repository to `~/linux-setup`
3. Runs the Ansible playbook (prompts for sudo and vault passwords)

## Repository Structure

```
linux-setup/
├── bootstrap.sh          # Setup script
├── ansible/              # Ansible playbooks
│   ├── inventory.ini
│   └── playbook.yml
└── dotfiles/             # Configuration files
    ├── i3/
    ├── terminal/
    └── ...
```

## Customization

### Adding Packages
Edit `ansible/playbook.yml` and add your packages

### Adding Dotfiles
```bash
# Copy your config to dotfiles/ maintaining the directory structure
cd ~/linux-setup/dotfiles
stow <package-name>  # Creates symlinks to $HOME
```

### Managing Secrets
```bash
ansible-vault encrypt sensitive-file.yml
ansible-vault edit sensitive-file.yml
```

## Manual Ansible Execution

```bash
cd ~/linux-setup/ansible
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass
```

## License

Personal configuration repository. Fork and adapt as needed.
