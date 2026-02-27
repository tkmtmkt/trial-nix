Nix
===

## 操作

```
# dockerイメージ作成
bin/build.sh

# イメージ確認
bin/images.sh

# dockerコンテナ作成してbash実行
bin/run.sh
```

## 参考

### ディレクトリ構成

```
/home/setup
|-- .config/
|   |-- home-manager/
|   |   |-- flake.lock
|   |   |-- flake.nix
|   |   `-- home.nix
|   `-- nix/
|       `-- nix.conf
|-- .local/
|   |-- share/
|   |   |-- home-manager/
|   |   `-- uv/
|   |       `-- python/
|   `-- state/
|       |-- home-manager/
|       `-- nix/
|           `-- profiles/
|               |-- channels -> channels-1-link/
|               |-- channels-1-link -> /nix/store/ra3vim6szfqk10kdmvx08q4qf8vhk0rz-user-environment/
|               |-- home-manager -> home-manager-1-link/
|               |-- home-manager-1-link -> /nix/store/1fzgn9r8614zv7li9g8w0lyc4wna9f4g-home-manager-generation/
|               |-- profile -> profile-2-link/
|               |-- profile-1-link -> /nix/store/qwgafbjdrz82ya7i1z18z23d1l59kmvm-user-environment/
|               `-- profile-2-link -> /nix/store/nqwifm13jjhjnacz8by18kpkb1h497f9-user-environment/
|-- .nix-channels
|-- .nix-defexpr/
|   |-- channels -> /home/setup/.local/state/nix/profiles/channels/
|   `-- channels_root -> /nix/var/nix/profiles/per-user/root/channels
`-- .nix-profile -> /home/setup/.local/state/nix/profiles/profile/
```

### Nix

インストールとセットアップ

```sh
# Nixインストール
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
$ . ~/.nix-profile/etc/profile.d/nix.sh
$ nix --version

# Flakesを有効にする（~/.config/nix/nix.conf）
$ mkdir -p ~/.config/nix
$ cat <<'EOF' > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# home-manager初期設定
$ nix run home-manager/master -- init

# home-manager有効化
$ nix run home-manager -- switch
```

プロジェクト

```sh
# 設定確認
$ nix config show

# Nixを更新する
$ nix upgrade-nix

# パッケージ名を検索する
$ nix search nixpkgs#パッケージ名 ^

# パッケージを一時的にインストールしてコマンドを実行する
$ nix run nixpkgs#cowsay hello!

# パッケージを一時的にインストールしてshellを実行する
$ nix shell nixpkgs#cowsay
$ cowsay hello!

# パッケージをインストールする
$ nix profile add nixpkgs#cowsay
$ nix profile list
$ cowsay hello!
```

### 参考サイト

- パッケージ
  - [GitHub - NixOS/nixpkgs: Nix Packages collection & NixOS](https://github.com/nixos/nixpkgs)
  - [Nixhub.io | A Nix Packages Registry](https://www.nixhub.io/)
  - [NixOS Search - Packages](https://search.nixos.org/packages)
- インストール
  - [Download | Nix & NixOS](https://nixos.org/download/#nix-install-linux)
  - [GitHub - DeterminateSystems/nix-installer: Install Nix and flakes with the fast and reliable Determinate Nix Installer, with over 7 million installs.](https://github.com/DeterminateSystems/nix-installer)
