#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# Nixインストール
sh <(curl -L https://nixos.org/nix/install) --no-daemon
cp -r ${SCRIPT_DIR}/_config/ ~/.config/

# Nix設定
. ~/.nix-profile/etc/profile.d/nix.sh

# Nixパッケージ追加
# https://www.nixhub.io/
nix profile add nixpkgs/80d901ec0377e19ac3f7bb8c035201e2e098cc97#geos   # 3.14.1
nix profile add nixpkgs/80d901ec0377e19ac3f7bb8c035201e2e098cc97#gdal   # 3.12.2
nix profile add nixpkgs/80d901ec0377e19ac3f7bb8c035201e2e098cc97#proj   # 9.7.1
nix profile add nixpkgs#uv
