{
  inputs,
  cell,
  pkgs,
}:
{
  systemPackages = with pkgs; [
    protontricks
    heroic
    lutris
    osu-lazer-bin
    sunshine
    moonlight-qt
  ];
}
