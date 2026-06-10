{
  description = "Home Manager configuration of j";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs;
        dotfilesSrc = self.outPath;  # store copy, for readDir only
        dotfiles = "/home/j/git/dotfiles";  # live path, for symlink targets
      };
    in
    {
      # TCS config
      homeConfigurations."j@lenny" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
      		./home-manager/common.nix
      		./home-manager/lenny.nix
      	];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        inherit extraSpecialArgs;
      };

      # Home
      homeConfigurations."j" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        inherit extraSpecialArgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
      		./home-manager/common.nix
      	];
      };
    };
}
