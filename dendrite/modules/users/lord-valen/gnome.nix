{ lib, self, ... }:
{
  flake.modules.nixos.gnome = self.lib.importForUser "lord-valen" "gnome";
}
