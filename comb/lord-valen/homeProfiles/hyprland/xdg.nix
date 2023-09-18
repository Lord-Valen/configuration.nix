{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) formats lib;
  toml = formats.toml {};
in {
  configFile."hypr-empty/config.toml".source = toml.generate "hypr-empty-settings" {
    components = builtins.map (i: {
      workspace = builtins.toString i;
      command = "wofi";
      args = ["-S" "drun"];
    }) (lib.range 1 10);
  };
}
