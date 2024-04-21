{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      config = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "clock"
          "wireplumber"
          "mpris"
        ];
        modules-center = [
          "hyprland/submap"
          "hyprland/workspaces"
        ];
        modules-right = [
          "cpu"
          "memory"
          "disk"
          "battery"
          "network"
          "tray"
        ];
        mpris = {
          format = "({player_icon}  {status_icon} ) {dynamic}";
          max-length = 999;
          player-icons = {
            default = "";
            mpv = "";
            vlc = "󰕼";
            brave = "";
            firefox = "";
          };
          status-icons = {
            playing = "";
            paused = "";
          };
        };
        "hyprland/workspaces" = {
          all-outputs = false;
        };
      };
    };
  };
}
