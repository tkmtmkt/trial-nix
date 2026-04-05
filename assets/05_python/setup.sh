#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# 環境設定
export USER=$(id -un)
set +o nounset
. ~/.bash_profile
set -o nounset

# ファイル配置
git clone -b main https://github.com/tkmtmkt/trial-django.git ~/trial-django
ln -s ~/trial-django/code ~/code
cd ~/code

# プロジェクト環境設定
uv sync --frozen --no-install-project
uv run manage.py collectstatic --no-input
uv cache clean

# システム設定
sudo sh etc/httpd/setup.sh
sudo sh etc/systemd/setup.sh
