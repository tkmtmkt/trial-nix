FROM almalinux:9.6

# OSパッケージインストール
RUN --mount=type=cache,target=/var/cache/dnf <<'EOF'
echo 9.6 > /etc/dnf/vars/release
set -o errexit
dnf -y update
dnf clean all
EOF

# Nixインストール
RUN curl -fsSL https://install.determinate.systems/nix | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"
# uvインストール
# https://www.nixhub.io/
RUN <<'EOF'
nix profile add nixpkgs#uv
nix profile add nixpkgs#geos
nix profile add nixpkgs#gdal
nix profile add nixpkgs#proj
EOF

# ユーザ追加
RUN useradd -u 1000 -m setup

USER setup
WORKDIR /home/setup/src

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1
# Pythonパッケージインストール
ENV UV_LINK_MODE=copy
RUN --mount=type=cache,target=/home/code/.local/share/virtualenv <<'EOF'
# uv環境にpython3.11インストール
#uv python install 3.14
# uvプロジェクト作成
uv init --python 3.14
# プロジェクト環境にパッケージインストール
uv add ipython
uv sync
EOF
RUN cat <<EOF > ~/.bash_aliases
alias ls='ls --color=auto -F'
alias ll='ls -l'
EOF
