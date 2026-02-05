{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "j";
  home.homeDirectory = "/home/j";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Desktop
    pavucontrol
    wofi
    waybar
    mako 	# Notification daemon
    hyprlock 	# Lock
    hypridle	# Run lock on idle

    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.monoid

    wezterm

    # Editors
    emacs
    neovim # This and packages.neovim.enable cannot be done at the same time
    helix

    # Utils
    jq
    bat 	# Replacement for less
    delta # Replacement for less (for git diff and the like)
    eza 	# Better ld
    zoxide 	# better cd
    yazi 	# File manager
    ripgrep 	# Better search
    fzf		# Fuzzy file finder
    dust	# File disk utilization
    gnumake

    zenith 	# System monitor

    # Productivity
    taskwarrior3
    taskwarrior-tui
    timewarrior

    # Shells
    fish
    grc 	# Colorizer
    fishPlugins.grc
    starship
    zellij

    # Dev tools
    git
    lazygit

    # Python
    python3
    uv

    #uutils-coreutils

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/j/etc/profile.d/hm-session-vars.sh
  #
  xdg.enable = true;
  # I am not sure this is working
  home.sessionVariables = {
    XDG_BIN_HOME    = "${config.home.homeDirectory}/.local/bin";
    #This variable is overriden. It does not work
    EDITOR = "hx";
    PAGER = "bat";
  };
  home.sessionPath = [ "$XDG_BIN_HOME" ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.eza = {
  	enableFishIntegration = true;
	icons = "auto";
	git = true;
	extraOptions = [
		"--color=always"
		"--tree"
		"--level=1"
		"--group-directories=first"
		"--dereference"
	];
  };

  home.shellAliases = {
  	lg = "lazygit";
	gs = "git status";
  };

  programs.fish = {
      enable = true;
      interactiveShellInit = ''
	      set fish_greeting
	      fish_add_path -g $HOME/.local/bin
      '';
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      ];
  };

  programs.starship = {
    enable = true;
    settings = {
	    add_newline = false;
    };
  };

  #programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  programs.zoxide.enable = true;
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    ''; # Launch fish on startup
  };

  fonts.fontconfig.enable = true;

  xdg.configFile = {
    "git" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/git/.config/git";
      recursive = true;
    };
  };
}
