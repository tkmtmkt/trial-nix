#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# ユーザ追加
useradd -u 1000 -m setup -G wheel
echo 'Passw0rd' | passwd --stdin setup
echo "setup   ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
