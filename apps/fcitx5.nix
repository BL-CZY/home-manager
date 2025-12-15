{ config, pkgs, ... }:

{
    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;

        fcitx5.addons = with pkgs; [
            kdePackages.fcitx5-chinese-addons
        ];

        fcitx5.settings = {
            inputMethod = {
                GroupOrder."0" = "Default";
                "Groups/0" = {
                    Name = "Default";
                    "Default Layout" = "us";
                    DefaultIM = "keyboard-us";
                };
                "Groups/0/Items/0".Name = "keyboard-us";
                "Groups/0/Items/1".Name = "pinyin";
            };

            globalOptions = {
                "Hotkey/TriggerKeys" = {
                    "0" = "Control+Control_R";
                };
            };
        };
    };
}
