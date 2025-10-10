#!/usr/bin/env bash
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
        else
            print_error "Cannot detect Linux distribution"
            exit 1
        fi
    else
        print_error "Unsupported operating system: $OSTYPE"
        print_error "This script only supports Linux distributions"
        exit 1
    fi
    print_info "Detected OS: $OS"
}

# Function to install packages based on OS
install_packages() {
    print_info "Installing Ansible, Git, and Stow..."

    case "$OS" in
        fedora)
            print_info "Using DNF package manager"
            sudo dnf install -y ansible git stow
            ;;
        ubuntu|debian|pop)
            print_info "Using APT package manager"
            sudo apt update
            sudo apt install -y ansible git stow
            ;;
        arch|manjaro)
            print_info "Using Pacman package manager"
            sudo pacman -Sy --noconfirm ansible git stow
            ;;
        opensuse*)
            print_info "Using Zypper package manager"
            sudo zypper install -y ansible git stow
            ;;
        *)
            print_error "Unsupported OS: $OS"
            print_error "Supported operating systems: Fedora, Ubuntu, Debian, Arch, Manjaro, openSUSE"
            exit 1
            ;;
    esac

    print_info "Packages installed successfully"
}

# Function to clone repository
clone_repository() {
    if [ ! -d ~/linux-setup ]; then
        print_info "Cloning repository..."
        git clone https://github.com/WoutDeleu/linux-setup ~/linux-setup
        print_info "Repository cloned successfully"
    else
        print_info "Repository already exists at ~/linux-setup"
    fi
}

# Function to run Ansible playbook
run_ansible() {
    print_info "Running Ansible playbook..."
    cd ~/linux-setup/ansible
    ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass
}

# Main execution
main() {
    print_info "Starting bootstrap process..."

    detect_os
    install_packages
    clone_repository
    run_ansible

    print_info "Bootstrap completed successfully!"
}

main
