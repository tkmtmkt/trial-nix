FROM almalinux:9.6

# OSパッケージインストール
RUN --mount=type=cache,target=/var/cache/dnf <<'EOF'
set -o errexit
releasever=9.6
echo "${releasever}" > /etc/dnf/vars/releasever
ln -s RPM-GPG-KEY-EPEL-9 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${releasever}
dnf -y install epel-release
dnf -y update
dnf clean all
EOF

# ユーザ追加
RUN <<'EOF'
set -o errexit
useradd -u 1000 -m setup
mkdir -m 0755 /nix
chown -R setup:setup /nix
EOF

USER setup
ENV USER=setup

RUN --mount=type=bind,source=./assets,target=/assets <<'EOF'
set -o errexit
# Nixインストール
sh <(curl -L https://nixos.org/nix/install) --no-daemon
cp -r /assets/_config/ /home/setup/.config/
# パッケージ追加
. /home/setup/.nix-profile/etc/profile.d/nix.sh
nix profile add nixpkgs/01b6809f7f9d1183a2b3e081f0a1e6f8f415cb09#geos
nix profile add nixpkgs/677fbe97984e7af3175b6c121f3c39ee5c8d62c9#gdal
nix profile add nixpkgs/ee09932cedcef15aaf476f9343d1dea2cb77e261#proj
# home-manager設定
nix run home-manager/master -- switch
EOF

# PYTHONDONTWRITEBYTECODEとPYTHONUNBUFFEREDはオプション
# pycファイル(および__pycache__)の生成を行わないようにする
ENV PYTHONDONTWRITEBYTECODE=1
# 標準出力・標準エラーのストリームのバッファリングを行わない
ENV PYTHONUNBUFFERED=1
# Pythonパッケージインストール
ENV UV_LINK_MODE=copy
RUN --mount=type=cache,target=/home/code/.local/share/virtualenv <<'EOF'
. /home/setup/.nix-profile/etc/profile.d/nix.sh
# uvプロジェクト作成
mkdir ~/code && cd ~/code
uv init --python 3.14
# プロジェクト環境にパッケージインストール
uv add ipython
uv sync
EOF

WORKDIR /home/setup
