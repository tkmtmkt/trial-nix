#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# Nix設定
. ~/.nix-profile/etc/profile.d/nix.sh

# home-manager設定
nix run home-manager/master -- switch
