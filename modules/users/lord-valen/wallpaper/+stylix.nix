{
  self,
  config,
  lib,
  ...
}:
{
  flake.modules.nixos.stylix = lib.mkMerge [
    (self.lib.importForUser "lord-valen" config.flake.modules.homeManager."lord-valen/stylix")
    {
      stylix.polarity = "dark";
      stylix.image = ./_wallpaper.d/ouroboros_by_chunlo_dcltl6k.jpg;
    }
  ];
  flake.modules.homeManager."lord-valen/stylix" = {
    stylix.polarity = "dark";
    stylix.image = ./_wallpaper.d/ouroboros_by_chunlo_dcltl6k.jpg;
  };
}
