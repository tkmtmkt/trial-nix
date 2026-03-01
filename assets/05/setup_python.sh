#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# ファイル配置
cp -r ${SCRIPT_DIR}/code ~/

# Nix設定
export USER=$(id -un)
. ~/.nix-profile/etc/profile.d/nix.sh

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
export PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
export PYTHONUNBUFFERED=1

# ユーザ環境にパッケージインストール
export UV_PROJECT_ENVIRONMENT=${HOME}/.local/share/uv/venv
cd ~/code
uv sync
uv cache clean
