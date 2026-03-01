#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# ファイル配置
mkdir -p ~/.config
cp -r ${SCRIPT_DIR}/_config/* ~/.config/

# Nix設定
export USER=$(id -un)
. ~/.nix-profile/etc/profile.d/nix.sh

# home-manager設定
nix run home-manager/master -- switch

rm -rf ~/.cache
