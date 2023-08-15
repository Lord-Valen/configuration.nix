{
  xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./_xmonad.d/xmonad.hs;
    };
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
}
