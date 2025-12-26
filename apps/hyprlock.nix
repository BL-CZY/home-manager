{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    
    settings = {
      # GENERAL
      general = {
        hide_cursor = true;
        no_fade_in = false;
        no_fade_out = false;
        grace = 0;
        disable_loading_bar = true;
      };

      # BACKGROUND
      background = [
        {
          monitor = "";
          path = builtins.toString ./swww/bg1.jpg;
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # INPUT FIELD
      input-field = [
        {
          monitor = "";
          size = "250, 40";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.5;
          dots_center = true;
          outer_color = "rgb(138, 173, 244)";
          inner_color = "rgb(36, 39, 58)";
          font_color = "rgb(202, 211, 245)";
          check_color = "rgb(245, 169, 127)";
          fail_color = "rgb(237, 135, 150)";
          fail_text = "wrong password";
          fade_on_empty = false;
          font_family = "JetBrains Mono Nerd Font Mono";
          placeholder_text = "<i><span foreground=\"##cad3f5\">Input Password...</span></i>";
          hide_input = false;
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
      ];

      # TIME
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M%p\")\"";
          color = "rgb(202, 211, 245)";
          font_size = 90;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
