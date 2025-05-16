{ inputs, cell }:
let
  stream = "stable";
in
{
  bee = {
    system = "x86_64-linux";
    pkgs = cell."pkgs-${stream}";
    # home = inputs."home-manager-${stream}";
    home = inputs.home-manager-unstable;
  };
  nixpkgs.flake.source = inputs."nixpkgs-${stream}".outPath;
}
