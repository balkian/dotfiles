{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
  	jujutsu
	ansible
	awscli2
	cargo-cross
	rustup
	rustc
	gcc
	vial
	chromium
  ];

}
