{ config, pkgs, lib, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        defaultKeymap = "viins";
        plugins = [
            {
                name = "zsh-syntax-highlighting";
                src = pkgs.zsh-syntax-highlighting;
                file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
            }
        ];
        initContent = lib.mkOrder 1000 ''
            bindkey '^ ' autosuggest-accept
            alias "ls -l"="eza -ahl"
            alias nix-clean="sudo nix-collect-garbage --delete-older-than 2d --cores 16 && nix-collect-garbage --delete-older-than 2d --cores 16"
            alias pwninit="pwninit --no-template"
            alias binja="cd ~/projects/binja_flake/ && nix run &"
        '';
    };

    programs.eza = {
        enable = true;
        enableZshIntegration = true;
    };
}
