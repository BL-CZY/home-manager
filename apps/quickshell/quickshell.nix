{ config, ... }:

{
    programs.quickshell = {
        enable = true;
        activeConfig = "default";
        configs = {
            default = ./default;
        };
    };
}
