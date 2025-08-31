{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ ];
  programs.git = {
      enable = true;
      userName = "J. Fernando Sánchez";
      userEmail = "balkian@gmail.com";
      extraConfig = {
              init.defaultBranch = "main";
      };
  };

}
