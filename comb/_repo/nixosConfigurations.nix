{
  inputs,
  cell,
}: let
  inherit (cell) nixosSuites;
in {
  larva = {
    bee.system = "x86_64-linux";
    bee.pkgs = inputs.nixpkgs;
    imports = [nixosSuites.larva];
  };
}
