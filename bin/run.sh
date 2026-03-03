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

docker run --rm -ti --name ${REPOSITORY} -h ${REPOSITORY} \
  -v ${BASE_DIR}:${BASE_DIR} \
  -w ${BASE_DIR} \
  ${REPOSITORY}:${TAG} bash -l
