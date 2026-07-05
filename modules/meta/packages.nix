{ inputs, ... }:
{
  imports = [ (inputs.pkgs-by-name.flakeModule or { }) ];
  perSystem.pkgsDirectory = ../../pkgs;
}
