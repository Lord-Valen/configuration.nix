{
  inputs,
  cell,
  config,
  pkgs,
  lib,
}:
let
  # FIXME: attribute 'pkgs' missing
  pkgs = inputs.nixpkgs;
in
{
  greetd.enable = true;
  greetd.settings.default_session.command = "${lib.getExe' pkgs.dbus "dbus-run-session"} ${lib.getExe config.programs.hyprland.package} --config /etc/greetd/hyprland.conf";
}
