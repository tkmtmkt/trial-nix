#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# Nix設定
export USER=$(id -un)
. ~/.nix-profile/etc/profile.d/nix.sh

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
export PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
export PYTHONUNBUFFERED=1

# ユーザ環境にパッケージインストール
export UV_PROJECT_ENVIRONMENT=${HOME}/.local/share/venv

# ファイル配置
mkdir -p ~/.config
cp -r ${SCRIPT_DIR}/_config/* ~/.config/
cp -r ${SCRIPT_DIR}/trial-django/code ~/

# サンプルプロジェクト
cd ~/code
uv sync
uv run python manage.py collectstatic
uv cache clean
