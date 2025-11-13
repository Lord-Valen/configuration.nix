{
  flake.aspects.gnome = {
    nixos = {
      xdg.portal.enable = true;

      services.libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      services.desktopManager.gnome.enable = true;
    };
    homeManager =
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
  };
  flake.modules.nixos.stylix = {
    stylix.targets.qt.enable = false;
  };
}
