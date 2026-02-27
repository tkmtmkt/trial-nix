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
docker build -t ${NAME} .

# タグ設定
TAG=$(docker images -q ${NAME}:latest)
TAG_COUNT=$(docker images | grep ${TAG} | wc -l)
if [[ ${TAG_COUNT} -eq 1 ]]; then
  docker tag ${NAME}:latest ${NAME}:$(date +%F-%H%M%S)
fi
