{
  self,
  config,
  ...
}:
{
  flake.modules.nixos.gnome = self.lib.importForUser "lord-valen" config.flake.modules.homeManager.gnome;
}
