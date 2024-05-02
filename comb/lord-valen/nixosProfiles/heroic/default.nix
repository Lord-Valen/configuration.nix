{
  inputs,
  cell,
  pkgs,
}:
{
  imports = with cell.nixosProfiles; [
    gamescope
    gamemode
  ];
  environment.systemPackages = with pkgs; [ heroic ];
}
