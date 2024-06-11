{
  inputs,
  cell,
  lib,
}:
let
  inherit (cell) homeProfiles;
in
{
  imports = [
    homeProfiles.anyrun
    homeProfiles.waybar
    homeProfiles.wlogout
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = cell.pkgs-unstable.hyprland;

    settings = {
      env = [
        "GDK_BACKEND, wayland, x11"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"

        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"

        "XCURSOR_SIZE, 18"
      ];

      input = {
        follow_mouse = 1;
        mouse_refocus = false;
        touchpad.natural_scroll = true;
        sensitivity = 0;
        kb_options = "compose:caps";
      };

      general = {
        gaps_in = 5;
        gaps_out = 7.5;
        border_size = 0;
        "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = lib.mkDefault "rgba(595959aa)";

        layout = "master";
      };

      decoration = {
        rounding = 10;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = lib.mkDefault "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      master = {
        new_is_master = false;
        new_on_top = true;
        no_gaps_when_only = false;
        orientation = "right";
      };

      gestures.workspace_swipe = true;

      misc.disable_hyprland_logo = true;

      "plugin:hyprfocus" = {
        enabled = true;

        keyboard_focus_animation = "flash";
        mouse_focus_animation = "flash";

        bezier = [
          "bezIn, 0.5,0.0,1.0,0.5"
          "bezOut, 0.0,0.5,0.5,1.0"
        ];

        flash = {
          flash_opacity = 0.7;

          in_bezier = "bezIn";
          in_speed = 0.5;

          out_bezier = "bezOut";
          out_speed = 2;
        };
      };

      # Keybinds
      "$mainMod" = "SUPER";
      "$manipMod" = "$mainMod SHIFT";
      "$metaMod" = "$mainMod SHIFT CTRL";

      "$terminal" = "alacritty";
      "$appLauncher" = "anyrun";
      "$browser" = "brave";
      "$emacs" = "emacsclient -c -a emacs";
      "$locker" = "swaylock";
      "$screenshot" = "watershot -c";

      "$1" = 1;
      "$2" = 2;
      "$3" = 3;
      "$4" = 4;
      "$5" = 5;
      "$6" = 6;
      "$7" = 7;
      "$8" = 8;
      "$9" = 9;
      "$0" = 10;

      bind = [
        "$metaMod, X, exec, wlogout"
        "$metaMod, L, exec, $locker"
        "$mainMod, Return, exec, $terminal"
        "$mainMod SHIFT, Return, exec, $appLauncher"
        "$mainMod, B, exec, $browser"
        "$mainMod SHIFT, S, exec, $screenshot"

        # Navigation
        "$mainMod, H, movefocus, l"
        "$mainMod, J, layoutmsg, cyclenext"
        "$mainMod, K, layoutmsg, cycleprev"
        "$mainMod, L, movefocus, r"

        "$mainMod, M, movefocus, l"
        "$mainMod, N, layoutmsg, cyclenext"
        "$mainMod, E, layoutmsg, cycleprev"
        "$mainMod, I, movefocus, r"

        "$mainMod, left, movefocus, l"
        "$mainMod, down, layoutmsg, cyclenext"
        "$mainMod, up, layoutmsg, cycleprev"
        "$mainMod, right, movefocus, r"

        "$mainMod, comma, focusmonitor, l"
        "$mainMod, period, focusmonitor, r"

        "$mainMod, 1, workspace, $1"
        "$mainMod, 2, workspace, $2"
        "$mainMod, 3, workspace, $3"
        "$mainMod, 4, workspace, $4"
        "$mainMod, 5, workspace, $5"
        "$mainMod, 6, workspace, $6"
        "$mainMod, 7, workspace, $7"
        "$mainMod, 8, workspace, $8"
        "$mainMod, 9, workspace, $9"
        "$mainMod, 0, workspace, $0"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Manipulation
        "$manipMod, Q, killactive"
        "$manipMod, W, togglefloating"
        "$manipMod, P, pin, active"
        "$manipMod, Space, fullscreen"

        "$manipMod, H, layoutmsg, removemaster"
        "$manipMod, J, layoutmsg, swapnext"
        "$manipMod, K, layoutmsg, swapprev"
        "$manipMod, L, layoutmsg, addmaster"
        "$manipMod, F, layoutmsg, swapwithmaster"

        "$manipMod, M, layoutmsg, removemaster"
        "$manipMod, N, layoutmsg, swapnext"
        "$manipMod, E, layoutmsg, swapprev"
        "$manipMod, I, layoutmsg, addmaster"
        "$manipMod, T, layoutmsg, swapwithmaster"

        "$manipMod, left, layoutmsg, removemaster"
        "$manipMod, down, layoutmsg, swapnext"
        "$manipMod, up, layoutmsg, swapnext, prev"
        "$manipMod, right, layoutmsg, addmaster"

        "$manipMod, comma, swapactiveworkspaces, current, l"
        "$manipMod, period, swapactiveworkspaces, current, r"

        "$manipMod, 1, movetoworkspace, $1"
        "$manipMod, 2, movetoworkspace, $2"
        "$manipMod, 3, movetoworkspace, $3"
        "$manipMod, 4, movetoworkspace, $4"
        "$manipMod, 5, movetoworkspace, $5"
        "$manipMod, 6, movetoworkspace, $6"
        "$manipMod, 7, movetoworkspace, $7"
        "$manipMod, 8, movetoworkspace, $8"
        "$manipMod, 9, movetoworkspace, $9"
        "$manipMod, 0, movetoworkspace, $0"
      ];

      bindm = [
        "$manipMod, mouse:272, movewindow"
        "$manipMod ALT, mouse:272, resizewindow"
        "$manipMod, mouse:273, resizewindow"
      ];

      monitor = lib.mkDefault ",preferred,auto,1";
    };

    extraConfig = ''
      # Emacs
      bind = $mainMod, A, submap, emacs

      submap = emacs
      bind = , A, exec, $emacs
      bind = , A, submap, reset
      bind = , catchall, submap, reset
      submap = reset
    '';
  };
}
