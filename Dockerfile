FROM almalinux:9.6

# OSパッケージインストール
RUN --mount=type=bind,source=./assets/01,target=/assets/01 \
  /assets/01/setup.sh

# ユーザ追加
RUN --mount=type=bind,source=./assets/02,target=/assets/02 \
  /assets/02/setup.sh

USER setup
ENV USER=setup

# Nix設定
RUN --mount=type=bind,source=./assets/03,target=/assets/03 \
  /assets/03/setup.sh

# home-manager設定
RUN --mount=type=bind,source=./assets/04,target=/assets/04 \
  /assets/04/setup.sh

# Python設定
RUN --mount=type=bind,source=./assets/05,target=/assets/05 \
  /assets/05/setup.sh

WORKDIR /home/setup
