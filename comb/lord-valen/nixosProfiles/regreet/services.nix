{
  inputs,
  cell,
  config,
}:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.nixpkgs) lib;
in
{
  greetd.enable = true;
  greetd.settings.default_session.command = "${lib.getExe' nixpkgs.dbus "dbus-run-session"} ${lib.getExe config.programs.hyprland.package} --config /etc/greetd/hyprland.conf";
}
