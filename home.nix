{ config, pkgs, ... }:

let 
  CONFIG_DIR = builtins.toString ./.;
in
{
  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tpl";
  home.homeDirectory = "/home/tpl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nemo-with-extensions
    brightnessctl
    neovim
    nodejs
    yarn
    wl-clipboard
    gvfs
    python3
    gh
    lazygit
    grim
    slurp
    swappy
    btop
    cmatrix
    unzip
    gcc

    # neovim LSPs
    pyright
    rust-analyzer
    coc-clangd
    svelte-language-server
    typescript-language-server
    lua-language-server
    nixd
    vscode-langservers-extracted
    qt6.qtdeclarative
    eslint
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
  #  /etc/profiles/per-user/tpl/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.obs-studio.enable = true;

  services.wl-clip-persist.enable = true;
  services.clipse.enable = true;
  services.gnome-keyring = {
      enable = true;
      components = ["secrets"];
  };

  imports = [
    (CONFIG_DIR + "/apps/kitty.nix")
    (CONFIG_DIR + "/apps/hyprland.nix")
    (CONFIG_DIR + "/apps/zsh.nix")
    (CONFIG_DIR + "/apps/starship.nix")
    (CONFIG_DIR + "/apps/vscode/vscode.nix")
    (CONFIG_DIR + "/apps/fcitx5.nix")
    (CONFIG_DIR + "/apps/swww/swww.nix")
    (CONFIG_DIR + "/theme.nix")
    (CONFIG_DIR + "/apps/quickshell/quickshell.nix")
    (CONFIG_DIR + "/conf.nix")
    (CONFIG_DIR + "/apps/tmux.nix")
    (CONFIG_DIR + "/apps/yazi.nix")
  ];
}
