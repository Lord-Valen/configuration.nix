{ lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = { };
  };
}
