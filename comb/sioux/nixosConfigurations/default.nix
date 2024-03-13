{ inputs, cell }:
let
  common = {
    bee = {
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs;
      home = inputs.home-manager;
    };
    time.timeZone = "Canada/Eastern";
  };
in
inputs.hive.findLoad {
  inherit cell;
  inputs = inputs // {
    inherit common;
  };
  block = ./.;
}
