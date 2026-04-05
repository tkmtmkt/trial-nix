FROM almalinux:9.7
LABEL maintainer="Takamatsu Makoto <tkmtmkt@gmail.com>"

# OSパッケージインストール
RUN --mount=type=bind,source=./assets/01_os,target=/assets \
  /assets/setup.sh

# ユーザ追加
RUN --mount=type=bind,source=./assets/02_user,target=/assets \
  /assets/setup.sh

# Nix設定
RUN --mount=type=bind,source=./assets/03_nix,target=/assets \
  gosu setup /assets/setup.sh

# home-manager設定
RUN --mount=type=bind,source=./assets/04_home,target=/assets \
  gosu setup /assets/setup.sh

# Python設定
# ADD命令でコミット情報の変更を検知する（これでキャッシュを無効化できる）
ADD https://github.com/tkmtmkt/trial-django/commits/main /dev/null
RUN --mount=type=bind,source=./assets/05_python,target=/assets \
    --mount=type=cache,target=/var/cache/tmp,uid=1000,gid=1000,mode=0777 \
  gosu setup /assets/setup.sh

CMD ["/sbin/init"]
