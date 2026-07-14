{
  inputs,
  ...
}:
{
  imports = [ (inputs.devshell.flakeModule or { }) ];
  perSystem =
    { self', lib, pkgs, ... }:
    {
      devshells.default = {
        env = [
          {
            name = "NH_FILE";
            eval = "$PRJ_ROOT/system.nix";
          }
        ];
        commands =
          let
            mkCategory = category: attrs: attrs // { inherit category; };
            nixCategory = mkCategory "nix";
            secretsCategory = mkCategory "secrets";
          in
          lib.map nixCategory [
            { package = self'.packages.write-files; }
            { package = pkgs.nixtamal; }
            { package = pkgs.nh; }
          ]
          ++ lib.map secretsCategory [
            { package = pkgs.age; }
            { package = pkgs.sops; }
          ];
      };
    };
}
