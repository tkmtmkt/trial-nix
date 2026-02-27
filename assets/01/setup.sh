#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

releasever=9.6
echo "${releasever}" > /etc/dnf/vars/releasever
ln -s RPM-GPG-KEY-EPEL-9 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${releasever}
dnf -y install epel-release
dnf -y update
dnf clean all
