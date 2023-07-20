# This Dockerfile aims to be a test environment for Neovim config
FROM debian:stable

# ==================================
# === Dependencies installation  ===
# ==================================
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    lsb-release \
    zip

# ==================================
# ===    Neovim installation     ===
# ==================================
WORKDIR /tmp
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root / && \
    ln -s /squashfs-root/AppRun /usr/bin/nvim

# ==================================
# ===    Neovim configuration    ===
# ==================================

WORKDIR /root/.config/nvim
SHELL ["/bin/bash"]
CMD ["/bin/bash"]
