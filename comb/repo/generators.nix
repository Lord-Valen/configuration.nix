{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs nixos-generators;
  inherit (nixpkgs) lib;
  inherit (nixos-generators) nixosGenerate;
in rec {
  default = install-iso;
  install-iso = nixosGenerate {
    pkgs = inputs.nixpkgs;
    modules =
      [
        {isoImage.isoName = lib.mkForce "larva.iso";}
      ]
      ++ cell.nixosSuites.larva;
    format = "install-iso";
  };
}
