{
  lib,
  config,
  ...
}: {
  xdg.configFile."keyboard.conf".text = lib.mkIf (config.home.xdg.configFile."hypr/hyprland.conf" != null) (lib.mkForce ''
    input {
      kb_layout = us
      kb_variant = colemak_dh
    }
  '');
}
