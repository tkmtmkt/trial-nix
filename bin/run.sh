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
docker run --privileged --rm -ti --name ${NAME} -h ${NAME} \
  -v ${BASE_DIR}:${BASE_DIR} \
  -w ${BASE_DIR} \
  -p 8000:80 \
  ${NAME} "$@"
