{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    ansible
    awscli2
    cargo-cross
    rustup
    rustc
    gcc
    python3Packages.jedi-language-server
    ruff
    vial
    chromium
    graphviz

    # Bloque VS Code corregido
    ((pkgs.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-python.python
        ms-vscode-remote.remote-containers
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    }).overrideAttrs (oldAttrs: {
      makeWrapperArgs = (oldAttrs.makeWrapperArgs or []) ++ [
        "--set-default" "NIXOS_OZONE_WL" "1" 
      ];
    })) # Los paréntesis dobles aseguran que se evalúe como un paquete único

  ];

  home.file = {
    ".config/Code/User/settings.json".text = ''
    {
        "window.titleBarStyle": "custom"
    }
    '';
  };
}
