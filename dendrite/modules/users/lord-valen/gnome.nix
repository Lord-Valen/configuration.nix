{
  self,
  config,
  ...
}:
{
  # TODO: write a module to wire these
  flake.modules.nixos.gnome = self.lib.importForUser "lord-valen" config.flake.modules.homeManager.gnome;
}
