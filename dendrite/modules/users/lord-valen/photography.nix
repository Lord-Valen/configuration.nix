{ self, config, ... }:
{
  flake.modules.nixos.photography = self.lib.importForUser "lord-valen" config.flake.modules.homeManager.photography;
}
