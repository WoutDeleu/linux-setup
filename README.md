# Linux Setup

> Fast disaster recovery and new PC setup for Fedora i3 environments

This repository enables you to go from a fresh install to a fully configured i3 desktop in minutes instead of days. It combines Ansible for package installation, GNU Stow for dotfile management, and Ansible Vault for secure credential storage.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Supported Operating Systems](#supported-operating-systems)
- [Quick Start](#quick-start)
- [Repository Structure](#repository-structure)
- [Detailed Usage](#detailed-usage)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

This repository provides an automated solution for:
- **System Recovery**: Quickly restore your development environment after hardware failure
- **New PC Setup**: Set up a new machine with your preferred configuration in minutes
- **Configuration Sync**: Keep your dotfiles and system configuration in version control

### Key Components

- **Ansible**: Automates package installation and system configuration
- **GNU Stow**: Manages dotfiles via symlinks (easy to maintain and update)
- **Ansible Vault**: Securely stores sensitive configuration (SSH keys, git credentials, API tokens)

## Prerequisites

Before running the bootstrap script, ensure you have:

### Required

- ✅ **Fresh OS Installation**: A clean installation of a supported operating system (see below)
- ✅ **Internet Connection**: Required for downloading packages and dependencies
- ✅ **Sudo/Root Access**: You'll need administrator privileges to install packages
- ✅ **Sufficient Disk Space**: At least 5-10 GB of free disk space (depending on packages)

### Optional

- 📦 **GitHub Access**: If this repository is private, ensure you have access configured
- 🔐 **Ansible Vault Password**: If you're using encrypted secrets, you'll need the vault password

### System Requirements

- **CPU**: Any modern processor
- **RAM**: Minimum 2 GB (4 GB+ recommended for i3 + development tools)
- **Disk**: 5-10 GB minimum for base install (more for development environments)

## Supported Operating Systems

The bootstrap script automatically detects your OS and uses the appropriate package manager:

| Operating System | Package Manager | Status |
|-----------------|-----------------|--------|
| Fedora | DNF | ✅ Fully Supported |
| Ubuntu/Debian/Pop!_OS | APT | ✅ Fully Supported |
| Arch Linux/Manjaro | Pacman | ✅ Fully Supported |
| openSUSE | Zypper | ✅ Fully Supported |

## Quick Start

### 1. Download and Run Bootstrap Script

```bash
# Download the bootstrap script
curl -O https://raw.githubusercontent.com/WoutDeleu/linux-setup/main/bootstrap.sh

# Make it executable
chmod +x bootstrap.sh

# Run it
./bootstrap.sh
```

The script will:
1. Detect your operating system
2. Install Ansible, Git, and Stow
3. Clone this repository to `~/linux-setup`
4. Run the Ansible playbook (will prompt for sudo and vault passwords)

### 2. Enter Passwords When Prompted

- **Sudo password**: Required for package installation
- **Vault password**: Required if you're using Ansible Vault for secrets

### 3. Reboot (if required)

Some system configurations may require a reboot to take effect.

## Repository Structure

```
linux-setup/
├── bootstrap.sh          # Main entry point - OS-agnostic setup script
├── ansible/              # Ansible playbooks and configuration
│   ├── inventory.ini     # Ansible inventory file
│   ├── playbook.yml      # Main playbook
│   └── ...               # Other playbooks and roles
├── dotfiles/             # Configuration files organized by application
│   ├── i3/               # i3 window manager config
│   ├── terminal/         # Terminal emulator config
│   ├── git/              # Git configuration
│   └── ...               # Other application configs
├── CLAUDE.md             # Instructions for Claude Code
└── README.md             # This file
```

### Dotfiles Structure

Each subdirectory in `dotfiles/` represents a "stow package" that gets symlinked to `$HOME`:

```
dotfiles/i3/.config/i3/config  →  ~/.config/i3/config
```

## Detailed Usage

### Manual Ansible Execution

If you need to re-run the playbook or run it manually:

```bash
cd ~/linux-setup/ansible
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass
```

### Using Stow for Dotfiles

To apply dotfiles for a specific application:

```bash
cd ~/linux-setup/dotfiles
stow i3        # Creates symlinks for i3 config
stow terminal  # Creates symlinks for terminal config
```

To remove symlinks:

```bash
stow -D i3     # Removes i3 symlinks
```

## Customization

### Adding New Packages

1. Edit the Ansible playbook in `ansible/playbook.yml`
2. Add your packages to the appropriate task
3. Run the playbook again

### Adding New Dotfiles

1. Copy your config files to `dotfiles/` maintaining the directory structure relative to `$HOME`
2. Use `stow` to create symlinks:
   ```bash
   cd dotfiles
   stow <package-name>
   ```
3. Commit to git

### Managing Secrets with Ansible Vault

To encrypt sensitive files:

```bash
ansible-vault encrypt sensitive-file.yml
```

To edit encrypted files:

```bash
ansible-vault edit sensitive-file.yml
```

To view encrypted files:

```bash
ansible-vault view sensitive-file.yml
```

**Important**: Store your vault password securely (password manager, encrypted file, etc.). Never commit it to the repository.

## Troubleshooting

### Bootstrap Script Fails

**Problem**: Script fails to detect OS
```bash
# Check your OS type
echo $OSTYPE
cat /etc/os-release  # On Linux
```

**Problem**: Permission denied
```bash
# Make sure the script is executable
chmod +x bootstrap.sh
```

### Ansible Errors

**Problem**: "Could not find playbook.yml"
```bash
# Ensure you're in the ansible directory
cd ~/linux-setup/ansible
```

**Problem**: Vault password incorrect
```bash
# Double-check your vault password
# Contact the repository owner if you don't have access
```

### Stow Conflicts

**Problem**: Stow reports conflicts
```bash
# Backup existing files
mv ~/.config/i3/config ~/.config/i3/config.backup

# Try stow again
cd ~/linux-setup/dotfiles
stow i3
```

### Package Installation Fails

**Problem**: Package not found
```bash
# Update package manager cache
sudo dnf update           # Fedora
sudo apt update           # Ubuntu/Debian
sudo pacman -Sy           # Arch
```

## License

This is a personal configuration repository. Feel free to fork and adapt for your own use.

## Contributing

This is a personal setup repository, but suggestions and improvements are welcome via issues or pull requests.

---

**Need help?** Open an issue in the GitHub repository.
