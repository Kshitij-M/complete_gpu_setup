#!/bin/bash

# Update the package index
echo "Updating package index..."
sudo apt-get update

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker's repository
echo "Adding Docker's repository..."
OS_CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
if [ -z "$OS_CODENAME" ]; then
    OS_CODENAME=$(. /etc/os-release && echo "$UBUNTU_CODENAME")
fi
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $OS_CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index with the new repository
echo "Updating package index with Docker repository..."
sudo apt-get update

# Install Docker Engine, CLI, containerd, and plugins
echo "Installing Docker Engine and related components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker is installed
echo "Verifying Docker installation..."
docker --version

echo "Docker installation completed."