#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# パッケージインストール
releasever=9.6
echo "${releasever}" > /etc/dnf/vars/releasever
ln -s RPM-GPG-KEY-EPEL-9 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${releasever}
dnf -y install epel-release
dnf -y update
dnf -y install \
  gcc-c++ \
  glibc-langpack-ja \
  glibc-locale-source \
  iproute \
  passwd \
  procps-ng \
  sudo
dnf clean all

# gosuインストール
GOSU_VERSION=1.19
curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64"
chmod +x /usr/local/bin/gosu

# 日本語設定
localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
echo 'LANG="ja_JP.UTF-8"' > /etc/locale.conf

# タイムゾーン設定
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
