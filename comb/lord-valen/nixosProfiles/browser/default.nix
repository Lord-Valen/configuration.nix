{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  environment.systemPackages = with nixpkgs; [
    brave
    librewolf
    tor-browser-bundle-bin
  ];
}
