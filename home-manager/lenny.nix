{ config, pkgs, ... }:
{
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
  ];

}
