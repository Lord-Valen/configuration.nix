{
  inputs,
  cell,
}: {
  configFile."hypr/hyprland.conf".source = ./_hyprland.conf;
  configFile."hypr/monitor.conf".text = cell.lib.mkDefault ''monitor=,preferred,auto,auto'';
  configFile."hypr/keyboard.conf".text = cell.lib.mkDefault ''
    input {
      kb_layout = us
    }
  '';
}