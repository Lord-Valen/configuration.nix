{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xorg.xkill
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  };

  services = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };

    picom = {
      enable = true;
      inactiveOpacity = 0.8;
      menuOpacity = 0.8;
      opacityRules = ["100:class_g = 'zoom'"];
      fade = true;
      fadeSteps = [0.1 0.1];
      vSync = true;
      settings = {
        frame-opacity = 0.6;
        blur = {
          method = "kawase";
          strength = 3;
          background = false;
          background-frame = false;
          background-fixed = false;
          kern = "3x3box";
        };
      };
    };
  };
}
