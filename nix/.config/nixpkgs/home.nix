{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alex";
  home.homeDirectory = "/Users/alex";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # FIXME: some of the packages commented out below are installed via homebrew
  # because of issues with Spotlight/Finder not finding them.
  home.packages = with pkgs; [
    # alacritty # installed with homebrew
    antibody
    asdf-vm
    autoconf
    autojump
    bash
    bat
    coreutils-prefixed
    curl
    diff-so-fancy
    direnv
    # firefox # installed with homebrew
    fzf
    ghostscript
    # git-crypt
    gnupg
    gnused
    go2nix
    htop
    jq
    # keepassxc # installed with homebrew
    # keybase # installed with homebrew
    # macvim # installed with homebrew
    # musescore # installed with homebrew
    niv
    neovim
    # obs-studio # installed with homebrew
    parallel
    reattach-to-user-namespace
    ripgrep
    shellcheck
    # signal-desktop # installed with homebrew
    # skype # installed with homebrew
    # slack # installed with homebrew
    starship
    # steam # installed with homebrew
    # teams # installed with homebrew
    # telegram # installed with homebrew
    thefuck
    tor
    tmux
    universal-ctags
    upx
    # vlc # installed with homebrew
    # vscodium # installed with homebrew
    # zoom-us # installed with homebrew
    zsh
  ];

  programs.direnv.enable = true;
}
