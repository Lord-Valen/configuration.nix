{
  inputs,
  ...
}:
{
  imports = [ (inputs.devshell.flakeModule or { }) ];
  flake-file.inputs.devshell.url = "github:numtide/devshell";
  perSystem =
    { self', lib, ... }:
    {
      devshells.default = {
        env = [
          {
            name = "NH_FlAKE";
            eval = "$PRJ_ROOT";
          }
        ];
        commands =
          let
            mkCategory = category: attrs: attrs // { inherit category; };
            nixCategory = mkCategory "nix";
          in
          lib.map nixCategory [
            { package = self'.packages.write-files; }
            { package = self'.packages.write-flake; }
          ];
      };
    };
}
