{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs) lib;
in {
  configFile."hypr/hyprland.conf".source = ./_hyprland.conf;
  configFile."hypr/monitor.conf".text = lib.mkDefault ''monitor=,preferred,auto,auto'';
  configFile."hypr/keyboard.conf".text = lib.mkDefault ''
    input {
      kb_layout = us
    }
  '';
}
