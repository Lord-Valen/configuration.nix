{ lib, ... }:
{
  flake.modules.nixos.gnome =
    { config, ... }:
    lib.mkIf (config.home-manager.users ? "lord-valen") {
      home-manager.users.lord-valen.imports = with config.flake.modules.home-manager; [
        gnome
      ];
    };
}
