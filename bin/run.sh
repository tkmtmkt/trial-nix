#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

cd ${BASE_DIR}
docker run --rm -ti -u root \
  -v ./nix/:/root/nix/ \
  -v ./code/:/home/setup/code/ \
  almalinux96-with-nix bash
