# Test Dotfiles in Docker
FROM archlinux:latest

# Install dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    git \
    bash \
    zsh \
    fish \
    curl \
    wget \
    sudo

# Create test user
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# Copy dotfiles
COPY --chown=testuser:testuser . /home/testuser/.dotfiles

# Set working directory
WORKDIR /home/testuser/.dotfiles

# Default command
CMD ["./install.sh", "--dry-run"]
