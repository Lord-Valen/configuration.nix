{ inputs, cell }:
let
  common = {
    bee.system = "x86_64-linux";
    bee.pkgs = inputs.nixpkgs;
    deployment = {
      allowLocalDeployment = true;
      tags = [
        "all"
        "lord-valen"
      ];
    };
  };
in
inputs.hive.findLoad {
  inherit cell;
  inputs = inputs // {
    inherit common;
  };
  block = ./.;
}
