{lib, ...}: {
  xdg.configFile."hypr/keyboard.conf".text = lib.mkForce ''
    input {
      kb_layout = us
      kb_variant = colemak_dh
    }
  '';
}
