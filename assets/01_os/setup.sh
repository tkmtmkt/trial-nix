#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# OSバージョン固定
releasever=9.7
echo "${releasever}" > /etc/dnf/vars/releasever

# パッケージリポジトリ追加(EPEL)
ln -s RPM-GPG-KEY-EPEL-9 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${releasever}
dnf install -y epel-release
dnf update -y

# パッケージインストール
dnf install -y \
  gcc-c++ \
  glibc-langpack-ja \
  glibc-locale-source \
  httpd \
  httpd-devel \
  iproute \
  openssh-clients \
  passwd \
  procps-ng \
  sudo
dnf clean all

# gosuインストール
GOSU_VERSION=1.19
curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64"
chmod +x /usr/local/bin/gosu

# 言語とタイムゾーン設定
echo 'LANG="ja_JP.UTF-8"' > /etc/locale.conf
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# サービス自動起動設定
systemctl enable httpd
