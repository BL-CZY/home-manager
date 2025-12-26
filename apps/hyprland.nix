{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      ################
      ### MONITOR ###
      ################
      monitor = [
        ",preferred,auto,1"
      ];

      ###################
      ### VARIABLES ###
      ###################
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$fileManager" = "nemo";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################
      env = [
      ];

      #####################
      ### GENERAL ###
      #####################
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;

        "col.active_border" = "rgb(585b70)";
        "col.inactive_border" = "rgb(585b70)";

        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      #####################
      ### DECORATION ###
      #####################
      decoration = {
        rounding = 10;
        rounding_power = 2;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      ###################
      ### ANIMATIONS ###
      ###################
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
          "custom, 0, 1, 0, 1"
          "default, 0, 1, 0, 1"
          "overshoot, 0.05, 0.9, 0.64, 1.1"
        ];

        animation = [
          "global, 1, 7, custom"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 7, custom, slide"
          "zoomFactor, 1, 7, quick"
          "layers, 1, 10, custom"
        ];
      };

      ###################
      ### LAYOUTS ###
      ###################
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      ###################
      ### MISC ###
      ###################
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      ###################
      ### INPUT ###
      ###################
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      ###################
      ### GESTURES ###
      ###################
      gesture = [
        "3, horizontal, workspace"
      ];

      ###################
      ### PER-DEVICE ###
      ###################
      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      ###################
      ### KEYBINDS ###
      ###################
      bind = [
        "$mainMod, return, exec, $terminal"
        "ALT, space, exec, $terminal python3"
        "$mainMod, F, exec, $browser"
        "$mainMod, C, killactive"
        "$mainMod SHIFT, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, W, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, V, exec, kitty --class clipse -e 'clipse'"
        "$mainMod, O, togglesplit"

        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "ALT,Tab,cyclenext,"
        "ALT,Tab,bringactivetotop,"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, qs ipc call volume increase"
        ",XF86AudioLowerVolume, exec, qs ipc call volume decrease"
        ",XF86AudioMute, exec, qs ipc call volume toggleMute"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, qs ipc call brightness increase"
        ",XF86MonBrightnessDown, exec, qs ipc call brightness decrease"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",Print, exec, name=$(date +'%s_grim.png');grim -g \"$(slurp)\" $HOME/Pictures/Screenshots/$name;swappy -f $HOME/Pictures/Screenshots/$name"
      ];

      exec-once = [
        ("swww " + builtins.toString ./swww/bg1.jpg)
        "quickshell"
        # "gnome-keyring-daemon --start --components=secrets"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      ###################
      ### WINDOW RULES ###
      ###################
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      windowrulev2 = [
        "float,class:^(kitty)$,title:^(kitty)$"
        "size 50% 60%,class:^(kitty)$,title:^(kitty)$"
        
        "float,class:nemo"
        "size 50% 60%,class:nemo"
        "float,class:Nemo-preview-start"
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
      ];

      layerrule = [
        "animation slide bottom, osd"
      ];
    };
  };
}
