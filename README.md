# nixfiles

Personal machine configuration using [Nix](https://nixos.org)
[home-manager](https://github.com/nix-community/home-manager).

Guide: https://ghedam.at/24353/tutorial-getting-started-with-home-manager-for-nix

## Nix setup

Install Nix package manager:

```sh
$ curl -L https://nixos.org/nix/install | sh
$ nix-shell -p nix-info --run "nix-info -m"
 - system: `"aarch64-darwin"`
 - host os: `Darwin 21.4.0, macOS 12.3.1`
 - multi-user?: `yes`
 - sandbox: `no`
 - version: `nix-env (Nix) 2.8.1`
 - channels(bfj): `"home-manager"`
 - channels(root): `"nixpkgs"`
 - nixpkgs: `/nix/var/nix/profiles/per-user/root/channels/nixpkgs`
```

Set `NIX_PATH` before installing `home-manager`:

```sh
$ export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
```

Install `home-manager`:

```sh
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```


## TODO

* [x] basic home manager setup
* [x] add basic nix packages to install
* [x] test macos development workflow with home-manager installed tools
* [ ] mirgrate dotfiles to `home.nix`
* [ ] test from scratch bootup on macos
* [ ] test from scratch bootup on Ubuntu/linux dev VM
* [ ] test from scratch bootup on AL2
* [ ] replace dotfiles with home-manager setup in [development-ansible](https://github.com/benjaminfjones/development-ansible)
