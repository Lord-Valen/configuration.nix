{
  den.aspects.sddm.nixos = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  den.aspects.kde.nixos = {
    services.displayManager.sddm.wayland.compositor = "kwin";
  };
}
