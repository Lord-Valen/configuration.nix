{
  inputs,
  cell,
  pkgs,
  lib,
}:
let
  # FIXME: attribute 'pkgs' missing
  pkgs = inputs.nixpkgs;
  toml = pkgs.formats.toml { };
  runner = pkgs.wofi;
in
{
  userDirs.enable = true;
  configFile."hypr-empty/config.toml".source = toml.generate "hypr-empty-settings" {
    components = builtins.map (i: {
      workspace = builtins.toString i;
      command = "${lib.getExe runner}";
      args = [
        "-S"
        "drun"
      ];
    }) (lib.range 1 10);
  };
}
