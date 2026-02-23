FROM almalinux:9.6

# OSパッケージインストール
RUN --mount=type=cache,target=/var/cache/dnf <<'EOF'
echo 9.6 > /etc/dnf/vars/release
set -o errexit
dnf -y update
dnf clean all
EOF

# ユーザ追加
RUN <<'EOF'
set -o errexit
useradd -u 1000 -m setup
mkdir -m 0755 /nix
chown setup /nix
EOF

USER setup

# Nixインストール
RUN <<'EOF'
set -o errexit
sh <(curl -L https://nixos.org/nix/install)
# Flakesを有効にする（~/.config/nix/nix.conf）
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
EOF

# Nixパッケージ追加
RUN <<'EOF'
# https://www.nixhub.io/
export USER=setup
. /home/setup/.nix-profile/etc/profile.d/nix.sh
type nix
nix profile add nixpkgs#geos
nix profile add nixpkgs#gdal
nix profile add nixpkgs#proj
nix profile add nixpkgs#uv
EOF

WORKDIR /home/setup/src
# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1
# Pythonパッケージインストール
ENV UV_LINK_MODE=copy
RUN --mount=type=cache,target=/home/code/.local/share/virtualenv <<'EOF'
export USER=setup
. /home/setup/.nix-profile/etc/profile.d/nix.sh
# uvプロジェクト作成
uv init --python 3.14
# プロジェクト環境にパッケージインストール
uv add ipython
uv sync
EOF
