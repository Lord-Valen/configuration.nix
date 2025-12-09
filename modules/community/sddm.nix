{
  flake.modules.nixos.sddm = {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  flake.modules.nixos.kde = {
    services.displayManager.sddm.wayland.compositor = "kwin";
  };
}
