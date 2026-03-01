#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
NAME=$(basename ${BASE_DIR})
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

cd ${BASE_DIR}
if [[ $# -eq 0 ]]; then
  docker exec -ti -u setup ${NAME} bash --login
else
  docker exec -ti -u setup ${NAME} "$@"
fi
