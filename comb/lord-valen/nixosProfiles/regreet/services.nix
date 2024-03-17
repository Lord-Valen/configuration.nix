{
  inputs,
  cell,
  config,
  pkgs,
  lib,
}:
{
  greetd.enable = true;
  greetd.settings.default_session.command = "${lib.getExe' pkgs.dbus "dbus-run-session"} ${lib.getExe config.programs.hyprland.package} --config /etc/greetd/hyprland.conf";
}
