{ inputs, lib, ... }:
{
  flake-file.inputs.pkgs-by-name.url = "github:drupol/pkgs-by-name-for-flake-parts";
  imports = [ (inputs.pkgs-by-name.flakeModule or { }) ];
  perSystem.pkgsDirectory = ../../pkgs;
}
