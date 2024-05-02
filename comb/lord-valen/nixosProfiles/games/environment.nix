{
  inputs,
  cell,
  pkgs,
}:
{
  systemPackages = with pkgs; [
    heroic
    lutris
  ];
}
