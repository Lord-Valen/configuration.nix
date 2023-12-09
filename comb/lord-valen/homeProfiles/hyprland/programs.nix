{
  inputs,
  cell,
}: {
  waybar = {
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
  wlogout = {
    enable = true;
    style = ./_wlogout/style.css;
  };
  swaylock = {
    package = inputs.nixpkgs.swaylock-effects;
    enable = true;
    settings = {
      screenshots = true;
      clock = true;
      indicator = "b56cd2";
      fade-in = 0.5;
      effect-blur = "7x5";
    };
  };
}
