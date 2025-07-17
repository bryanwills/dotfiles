#!/bin/bash

# Script to set up Ansible controller on Ubuntu

set -e

log() {
    echo -e "\033[0;32m[INFO]\033[0m $1"
}

# Update system
log "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Ansible
log "Installing Ansible..."
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Install additional tools
log "Installing additional tools..."
sudo apt install -y git curl wget vim

# Set up SSH key if not exists
if [ ! -f ~/.ssh/id_rsa ]; then
    log "Generating SSH key..."
    ssh-keygen -t rsa -b 4096 -C "ansible@homelab" -f ~/.ssh/id_rsa -N ""
fi

# Display public key for copying to target hosts
log "SSH public key (copy this to target hosts):"
cat ~/.ssh/id_rsa.pub

log "Ansible setup complete!"
log "Next steps:"
log "1. Copy the SSH key to your target hosts"
log "2. Update the inventory file with your host IPs"
log "3. Run: ansible-playbook -i inventory/hosts.yml playbooks/site.yml"
