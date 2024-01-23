set -U fish_greeting
set -g -x NIX_PATH "/home/j/.nix-defexpr/channels/:/nix/var/nix/profiles/per-user/root/channels"
starship init fish | source
