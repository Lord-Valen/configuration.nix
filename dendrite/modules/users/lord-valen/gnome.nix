{ lib, inputs, ... }:
{
  flake.modules.nixos.gnome = inputs.self.lib.importForUser "lord-valen" "gnome";
}
