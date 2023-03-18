{
  inputs,
  cell,
}: let
  inherit (cell) nixosSuites;
in {
  larva = {
    bee.system = "x86_64-linux";
    bee.pkgs = inputs.nixpkgs.legacyPackages;
    deployment = {
      targetHost = "fe80::47";
      targetPort = 22;
      targetUser = "root";
      allowLocalDeployment = false;
      buildOnTarget = false;
    };
    imports = [nixosSuites.larva];
  };
}
