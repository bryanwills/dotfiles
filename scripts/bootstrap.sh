#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect platform
detect_platform() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        *)       echo "unknown" ;;
    esac
}

install_ansible() {
    local platform=$(detect_platform)
    
    log "Installing Ansible for $platform..."
    
    case $platform in
        "macos")
            if ! command -v brew &> /dev/null; then
                log "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install ansible
            ;;
        "linux")
            if command -v apt &> /dev/null; then
                sudo apt update
                sudo apt install -y software-properties-common
                sudo add-apt-repository --yes --update ppa:ansible/ansible
                sudo apt install -y ansible
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y ansible
            else
                error "Unsupported Linux distribution"
                exit 1
            fi
            ;;
        *)
            error "Unsupported platform: $platform"
            exit 1
            ;;
    esac
}

main() {
    log "Starting dotfiles setup with Ansible..."
    
    # Install Ansible if not present
    if ! command -v ansible &> /dev/null; then
        install_ansible
    else
        log "Ansible already installed"
    fi
    
    # Navigate to the dotfiles directory
    cd "$(dirname "$0")/.."
    
    # Run Ansible playbook
    log "Running Ansible playbook..."
    cd ansible
    ansible-playbook -i inventory/hosts.yml playbooks/site.yml --ask-become-pass
    
    log "Dotfiles setup complete!"
    log "Please restart your shell or run: exec zsh"
}

main "$@"
