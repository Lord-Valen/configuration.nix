{
  inputs,
  cell,
  pkgs, # FIXME: attribute 'pkgs' missing
}:
let
  pkgs = inputs.nixpkgs; # workaround FIXME
  inherit (pkgs.callPackage inputs.stylix.inputs.base16.lib { }) mkSchemeAttrs;
in
mkSchemeAttrs {
  base00 = "0C0A20";
  base01 = "110D26";
  base02 = "1F1147";
  base03 = "546A90";
  base04 = "204052";
  base05 = "7984D1";
  base06 = "F2F3F7";
  base07 = "2D2844";
  base08 = "E61F44";
  base09 = "DF85FF";
  base0A = "FFD400";
  base0B = "7984D1";
  base0C = "1EA8FC";
  base0D = "42C6FF";
  base0E = "FF2AFC";
  base0F = "3F88AD";
}
