{ inputs, cell }:
{
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs;
  home = inputs.home-manager;
}
