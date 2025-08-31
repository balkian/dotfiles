{ config, pkgs, nixgl, ... }:
let nixgl = import <nixgl> {};
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "j";
  home.homeDirectory = "/home/j";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = [                               
    pkgs.htop
    pkgs.zoom-us
    pkgs.fortune
    pkgs.tmux
    pkgs.git
    pkgs.git-lfs
    pkgs.hugo
    pkgs.fish
    pkgs.fd
    pkgs.helix
    pkgs.starship
    pkgs.ripgrep
    pkgs.eza
    pkgs.ansible
    pkgs.ranger
    pkgs.sshpass
    pkgs.jq
    pkgs.bat
    pkgs.davfs2
    pkgs.pandoc
    pkgs.rustup
    #pkgs.texlive
    # pkgs.texlive.combine {
    #   inherit (texlive) xcolor
    # }
    pkgs.wl-clipboard
    nixgl.auto.nixGLDefault
   #(pkgs.python311.withPackages (p: with p; [
    #jupyterlab
    #matplotlib
    #pandas
    #openpyxl
   #]))
    pkgs.alacritty
    pkgs.wezterm
    pkgs.kitty
    pkgs.zellij
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "Hack" "CascadiaCode" "FiraCode" "DejaVuSansMono" ]; })
  ];

  fonts.fontconfig.enable = true;
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      auto-pairs
      fzf-vim
      lightline-vim
    ];
  };
  services.owncloud-client.enable = true;
}
