{ config, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        profiles.default = {
            enableUpdateCheck = false;
            keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);
            userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
        };
    };
}
