{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [
    brave
    librewolf
    tor-browser-bundle-bin
  ];
}
