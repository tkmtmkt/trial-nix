Nix
===

## 準備

### インストール

以下のコマンドを実行する。

```sh
$ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```
- [Download | Nix & NixOS](https://nixos.org/download/#nix-install-linux)

ログインし直してから以下のコマンドを実行し、バージョンを確認する。
```sh
$ nix --version
```

### 設定

以下のコマンドを実行してnix-command, flakesを有効化する。
```sh
$ mkdir -p ~/.config/nix
$ cat << 'EOF' > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```

configコマンド実行を確認する。
```sh
$ nix config show | grep feature
experimental-features = fetch-tree flakes nix-command
system-features = benchmark big-parallel kvm nixos-test uid-range
```

runコマンド実行を確認する。
```sh
$ nix run nixpkgs#cowsay hello!
```

### テンプレート作成

```sh
$ nix flake init
$ nix develop
```

- [Nixhub.io | A Nix Packages Registry](https://www.nixhub.io/)
- [NixOS Search - Packages](https://search.nixos.org/packages)
- [GitHub - NixOS/nixpkgs: Nix Packages collection & NixOS](https://github.com/nixos/nixpkgs)
- [GitHub - DeterminateSystems/nix-installer: Install Nix and flakes with the fast and reliable Determinate Nix Installer, with over 7 million installs.](https://github.com/DeterminateSystems/nix-installer)
