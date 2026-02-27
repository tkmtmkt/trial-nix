#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

useradd -u 1000 -m setup
mkdir -m 0755 /nix
chown -R setup:setup /nix
