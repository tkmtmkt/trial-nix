#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail
#set -o xtrace

# Nix設定
. ~/.nix-profile/etc/profile.d/nix.sh

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
export PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
export PYTHONUNBUFFERED=1

# uvプロジェクト作成
export UV_LINK_MODE=copy
mkdir ~/code && cd ~/code
uv init --python 3.14
# プロジェクト環境にパッケージインストール
#uv add ipython
uv sync
