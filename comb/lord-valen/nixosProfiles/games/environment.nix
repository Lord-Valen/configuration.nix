{ inputs, cell }:
{
  systemPackages = with inputs.nixpkgs; [
    protonup-ng
    protontricks
    heroic
    lutris
    osu-lazer-bin
    sunshine
    moonlight-qt
  ];
}
