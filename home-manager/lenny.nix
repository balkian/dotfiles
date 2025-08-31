{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
  	jujutsu
  ];
  programs.git = {
      enable = true;
      userName = "Fernando Sánchez";
      userEmail = "f.sanchez@thechannelstore.tv";
      extraConfig = {
              init.defaultBranch = "main";
      };
  };

}
