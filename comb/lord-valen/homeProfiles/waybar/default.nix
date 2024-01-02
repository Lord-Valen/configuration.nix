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
        "hyprland/workspaces" = {
          all-outputs = false;
        };
      };
    };
  };
}
