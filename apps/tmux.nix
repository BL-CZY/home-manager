{ config, pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        plugins = with pkgs; [
            {
                plugin = tmuxPlugins.catppuccin;
                extraConfig = "set -g @catppuccin_flavor 'mocha'";
            }
        ];
        # extraConfig = "set -as terminal-features \",xterm-kitty:RGB\"";
        extraConfig = ''
            set -g default-terminal 'tmux-256color'
            set -sa terminal-features ',xterm-kitty:RGB'
        '';
    };
}
