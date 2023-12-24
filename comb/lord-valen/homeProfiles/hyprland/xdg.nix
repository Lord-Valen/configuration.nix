{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) formats lib;
  toml = formats.toml {};
  runner = nixpkgs.wofi;
in {
  userDirs.enable = true;
  configFile."hypr-empty/config.toml".source = toml.generate "hypr-empty-settings" {
    components = builtins.map (i: {
      workspace = builtins.toString i;
      command = "${lib.getExe runner}";
      args = ["-S" "drun"];
    }) (lib.range 1 10);
  };
}
