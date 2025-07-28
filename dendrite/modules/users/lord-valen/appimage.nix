{
  self,
  config,
  ...
}:
{
  flake.modules.nixos.appimage = self.lib.importForUser "lord-valen" config.flake.modules.homeManager.appimage;
}
