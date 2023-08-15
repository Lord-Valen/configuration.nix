{
  inputs,
  cell,
}: let
  inherit (inputs) common;
in {
  inherit (common) bee deployment;
}
