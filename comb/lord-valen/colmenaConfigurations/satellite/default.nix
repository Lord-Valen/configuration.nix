{
  inputs,
  cell,
}: let
  inherit (inputs) common;
  inherit (cell) nixosConfigurations;
in {
  imports = [nixosConfigurations.satellite];
  inherit (common) bee deployment;
}
