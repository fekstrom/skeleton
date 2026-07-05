FROM ubuntu:24.04

COPY tools/install_dependencies_from_source.cmake /stage/

RUN <<EOF
#
####
set -ex
#
#### Install apt packages ####
apt-get update
apt-get --yes --quiet install \
    build-essential \
    ca-certificates \
    doxygen \
    git \
    ninja-build \
    pipx \
    wget

apt-get autoremove
#
#### Install Gersemi ####
pipx install gersemi==0.27.7
#
#### Install CMake ####
wget -P /stage/ https://github.com/Kitware/CMake/releases/download/v4.2.3/cmake-4.2.3-linux-x86_64.sh
chmod +x /stage/cmake-4.2.3-linux-x86_64.sh
/stage/cmake-4.2.3-linux-x86_64.sh --prefix=/usr/local --skip-license
#
#### Install dependencies ####
cmake \
    -D INSTALL_DIR=/dependencies \
    -P /stage/install_dependencies_from_source.cmake
#
#### Cleanup ####
rm -rf /stage
rm -rf /dependencies/stage
ldconfig
#
####
EOF

ENV CMAKE_GENERATOR=Ninja
ENV CMAKE_PREFIX_PATH=/dependencies

# Add install location of pipx to PATH.
ENV PATH="/root/.local/bin:${PATH}"
