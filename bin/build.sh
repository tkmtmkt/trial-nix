#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
NAME=$(basename ${BASE_DIR})
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

docker build -t ${NAME} ${BASE_DIR}

# タグ設定
LATEST_ID=$(docker images -q ${NAME}:latest)
LATEST_COUNT=$(docker images | grep ${LATEST_ID} | wc -l)
if [[ ${LATEST_COUNT} -eq 1 ]]; then
  docker tag ${NAME}:latest ${NAME}:$(date +%F-%H%M%S)
fi
