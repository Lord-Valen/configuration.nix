{
  inputs,
  cell,
  pkgs,
}:
{
  systemPackages = with pkgs; [
    protonup-ng
    protontricks
    heroic
    lutris
    osu-lazer-bin
    sunshine
    moonlight-qt
  ];
}
