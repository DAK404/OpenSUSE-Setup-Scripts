#!/bin/bash

set -e

# Install prerequisites
echo "Installing required packages..."
zypper install -y zsh git

# Clone Oh My Zsh globally
echo "Cloning Oh My Zsh into /opt/oh-my-zsh..."
if [ ! -d /opt/oh-my-zsh ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git /opt/oh-my-zsh
else
    echo "/opt/oh-my-zsh already exists. Skipping clone."
fi

# Create default .zshrc in /etc/skel
echo "Creating global .zshrc template for new users..."
tee /etc/skel/.zshrc > /dev/null <<'EOF'
export ZSH="/opt/oh-my-zsh"
ZSH_THEME="fino-time"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
EOF

# Set Zsh as default shell for new users
ZSH_PATH=$(command -v zsh)
echo "Setting Zsh as the default shell for new users..."
useradd -D -s "$ZSH_PATH"

# Copy to existing users (UID >= 1000)
echo "Configuring existing users..."
for user in $(awk -F: '$3 >= 1000 && $3 < 65534 { print $1 }' /etc/passwd); do
    USER_HOME=$(eval echo "~$user")
    if [ ! -f "$USER_HOME/.zshrc" ]; then
        echo " - Setting up Oh My Zsh for $user"
        cp /etc/skel/.zshrc "$USER_HOME/.zshrc"
        chown "$user:$user" "$USER_HOME/.zshrc"
        chsh -s "$ZSH_PATH" "$user"
    else
        echo " - $user already has .zshrc — skipping"
    fi
done

# Ensure zsh is in /etc/shells
echo "Ensuring $ZSH_PATH is listed in /etc/shells..."
if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | tee -a /etc/shells
else
    echo " - $ZSH_PATH already present in /etc/shells"
fi

echo "Oh My Zsh system-wide setup complete."