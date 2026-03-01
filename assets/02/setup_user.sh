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

# Nixストアディレクトリ作成
mkdir -m 0755 /nix
chown setup:setup /nix

# httpd設定
ln -s /home/setup/.config/etc/httpd.conf /etc/httpd/conf.d/setup.conf
chmod a+rx /home/setup
