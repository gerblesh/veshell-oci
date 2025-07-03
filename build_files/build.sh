#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# https://github.com/free-explorers/veshell/blob/main/docs/dependencies.md
dnf5 install -y rust \
    rustc \
    cargo \
    make \
    cmake \
    clang \
    ninja-build \
    gtk3-devel \
    libudev-devel \
    libseat-devel \
    libinput-devel \
    mesa-libgbm-devel \
    tmux \
    openssl-devel

rm -rf /root
mkdir -p /root/.cargo
mkdir -p /usr/veshell-src
git clone https://github.com/free-explorers/veshell.git /usr/veshell-src
cd /usr/veshell-src
make install

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
