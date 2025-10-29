{
  self,
  config,
  ...
}:
{
  flake.modules.nixos.audio = self.lib.importForUser "lord-valen" config.flake.modules.homeManager.audio;
}
