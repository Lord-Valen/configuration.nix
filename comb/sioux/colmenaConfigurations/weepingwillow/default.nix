{ inputs, cell }:
let
  inherit (inputs) common;
in
{
  imports = [
    inputs.cells.lord-valen.bee
    cell.nixosConfigurations.weepingwillow
  ];
  inherit (cell) deployment;
}
