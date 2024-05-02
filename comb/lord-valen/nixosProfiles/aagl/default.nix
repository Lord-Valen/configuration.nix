{
  inputs,
  cell,
  pkgs,
}:
{
  imports = with cell.nixosProfiles; [
    inputs.aagl-gtk-on-nix.nixosModules.default
    gamescope
    gamemode
  ];
  programs.anime-game-launcher.enable = true;
}
