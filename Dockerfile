FROM almalinux:9.6
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

# OSパッケージインストール
RUN --mount=type=bind,source=./assets/01,target=/assets \
  /assets/setup_os.sh

# ユーザ追加
RUN --mount=type=bind,source=./assets/02,target=/assets \
  /assets/setup_user.sh

# Nix設定
RUN --mount=type=bind,source=./assets/03,target=/assets \
  gosu setup /assets/setup_nix.sh

# home-manager設定
RUN --mount=type=bind,source=./assets/04,target=/assets \
  gosu setup /assets/setup_hm.sh

# Python設定
RUN --mount=type=bind,source=./assets/05,target=/assets \
  gosu setup /assets/setup_python.sh

CMD ["/sbin/init"]
