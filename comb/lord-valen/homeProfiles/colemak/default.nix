{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
in {
  xdg.configFile."hypr/keyboard.conf".text = lib.mkForce ''
    input {
      kb_layout = us
      kb_variant = colemak_dh
    }
  '';
}
