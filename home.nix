{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bfj";
  home.homeDirectory = "/Users/bfj";

  # Packages to install
  home.packages = [
    # foundational tools
    pkgs.neovim
    pkgs.tmux

    # development tools
    # TODO: setup asdf shell initialization
    pkgs.asdf-vm
    pkgs.nodejs
    pkgs.rustup

    # shell tools
    pkgs.entr
    pkgs.fd
    pkgs.fzf
    pkgs.fzf-zsh
    pkgs.ripgrep
    pkgs.scc
    pkgs.starship
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
