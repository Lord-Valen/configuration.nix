{
  inputs,
  cell,
  pkgs,
}:
{
  _imports = [ inputs.aagl-gtk-on-nix.nixosModules.default ];
  anime-game-launcher.enable = true;
  gamescope.enable = true;
  gamemode.enable = true;
}
