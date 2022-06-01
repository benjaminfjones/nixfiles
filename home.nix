{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";

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

  #
  # Dotfiles
  #

  # TODO: need to manually clone VimPlug 
  # curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  home.file.".config/nvim/init.vim".source = ./init.vim;
  home.file.".config/nvim/coc-settings.vim".source = ./coc-settings.vim;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #
  # Configure other tools
  #

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    envExtra = "export PATH=/home/ubuntu/.nix-profile/bin:$PATH";
    oh-my-zsh = {
        enable = true;
        plugins = ["sudo" "git" "asdf" "vi-mode"];
        theme = "ys";
    };
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      vim = "nvim -p";
      vi = "nvim -p";
      gst = "git status";
      gits = "git status";
      gcm = "git commit -m";
    };
  };

  programs.git = {
    enable = true;
    userName = "Benjamin F Jones";
    userEmail = "benjaminfjones@gmail.com";
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    terminal = "screen-256color";
  };

  programs.fzf.enable = true;
  programs.starship.enable = true;

}
