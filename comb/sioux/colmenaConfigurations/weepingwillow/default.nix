{ inputs, cell }:
let
  inherit (inputs) common;
in
{
  imports = [ cell.nixosConfigurations.weepingwillow ];
  inherit (inputs.cells.lord-valen) bee;
  inherit (cell) deployment;
}
