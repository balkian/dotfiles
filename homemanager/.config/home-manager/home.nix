{ config, pkgs, nixgl, ... }:
let nixgl = import <nixgl> {};
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "j";
  home.homeDirectory = "/home/j";

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
    pkgs.fortune
    pkgs.tmux
    pkgs.git
    pkgs.fish
    pkgs.helix
    pkgs.starship
    pkgs.ripgrep
    pkgs.eza
    pkgs.ansible
    pkgs.ranger
    pkgs.sshpass
    nixgl.auto.nixGLDefault
    pkgs.alacritty
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" ]; })
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
}
