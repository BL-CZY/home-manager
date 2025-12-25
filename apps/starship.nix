{ config, ... }:

{
    programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            add_newline = false;
            character = {
                success_symbol = "[[󱄅](cyan) ❯](white)";
            };
            directory = {
                style = "bold blue";
            };
        };
    };
}
