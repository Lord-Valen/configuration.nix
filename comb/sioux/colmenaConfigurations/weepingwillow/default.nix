{ inputs, cell }:
let
  inherit (inputs) common;
in
{
  imports = [ cell.nixosConfigurations.weepingwillow ];
  inherit (common) bee deployment;
}
