{
  inputs,
  cell,
  pkgs,
}:
{
  _imports = with cell.nixosProfiles; [
    inputs.aagl-gtk-on-nix.nixosModules.default
    gamescope
    gamemode
  ];
  anime-game-launcher.enable = true;
}
