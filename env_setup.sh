#!/bin/bash

# Exit on any error

set -e 

echo "Starting system setup... (DARK)"

# check if command exists
command_exists() {
	command -v "$1" > /dev/null 2>&1
}

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install basic development tools
echo "Installing development tool..."
sudo apt install -y \
	build-essential \
	git \
	curl \
	wget \
	unzip \
	zip \
	htop \
	software-properties-common \
	apt-transport-https

# Install Python tools
echo "Install Python development environmnet..."
sudo apt install -y \
	python3 \
	python3-pip \
	python3-venv

# Install Node.js via nvm
echo "Installing Node.js..."

# Install i3wm and related packages...
sudo apt install -y \
	i3 \
	i3status \
	i3lock \
	dmenu \
	nitrogen \
	picom \
	rofi \
	dunst \
	xbacklight \
	feh \
	pavucontrol \
	flameshot

# Install Docker
echo "Installing docker..."
if ! command_exists docker; then
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	sudo usermod -aG docker $USER
	rm get-docker.sh
fi

# Install some usefull applications
echo "Installing additional applications..."
sudo apt install -y \
	vlc \
	firefox \
	chromium-browser

# Set up Git configuration
echo "Configuring Git..."
read -p "Enter your  Git username: " git_username
read -p "Enter your Git email: " git_email
git config --global user.name "$git_username"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"

# setup SSH key for Git
echo "Setting up SSH key..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
	ssh-keygen -t ed25519 -C "$git_email" -f ~/.ssh/id_ed25519 -N ""
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
	echo "Your SSH public key:"
	cat ~/.ssh/id_ed25519.pub
	echo "Please add this key to your Github account"
fi

# Install and configure ZSH
echo "Installing and configuring ZSH..."
sudo apt install -y zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	chsh -s $(which zsh)
fi

# Setting up i3wm config
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/rofi
mkdir -p ~/.config/dunst

# optional copying configs 
cp -r i3/config ~/.config/i3/config
cp -r polybar ~/.config/polybar
cp -r rofi ~/.config/rofi

echo "Setup complete! Please logout and log back in for all changes to take effect."
