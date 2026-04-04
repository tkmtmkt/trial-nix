#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
BASE_DIR=$(cd ${SCRIPT_DIR}/..;pwd)
REPOSITORY=$(basename ${BASE_DIR})
TAG=latest
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

docker run --privileged --rm -td --name ${REPOSITORY} -h ${REPOSITORY} \
  -v ${HOME}:${HOME} \
  -w ${BASE_DIR} \
  -p 8000:80 \
  ${REPOSITORY}:${TAG} "$@"
