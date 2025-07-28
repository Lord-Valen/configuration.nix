{
  flake.modules.nixos.gnome = {
    xdg.portal.enable = true;

    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    services.xserver.desktopManager.gnome.enable = true;
  };

  flake.modules.homeManager.gnome =
    { pkgs, ... }:
    {
      programs.gnome-shell = {
        enable = true;
        extensions =
          with pkgs.gnomeExtensions;
          map (package: { inherit package; }) [
            paperwm
            switcher
            system-monitor
            status-icons
            lilypad
          ];
      };
    };
}
