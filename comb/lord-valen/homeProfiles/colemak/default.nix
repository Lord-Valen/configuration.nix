{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
in {
  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_layout = us
      kb_variant = colemak_dh
    }
  '';
}
