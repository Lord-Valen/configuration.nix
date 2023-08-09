{
  inputs,
  cell,
}: let
  inherit (cell) lib;

  common = {
    bee.system = "x86_64-linux";
    bee.pkgs = inputs.nixpkgs;
    deployment = {
      allowLocalDeployment = true;
      tags = ["all" "cluster2"];
    };
  };

  load = lib.load inputs cell;

  hosts = lib.loadAll load ./src;
in
  cell.lib.mkColmenaConfigurations cell common hosts
