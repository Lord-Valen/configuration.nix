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

  etc."greetd/hyprland.conf".text = lib.concatLines [
    ''
      exec-once = ${lib.getExe' nixpkgs.dbus "dbus-update-activation-environment"} --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = ${lib.getExe config.programs.regreet.package}; ${lib.getExe' config.programs.hyprland.package "hyprctl"} dispatch exit
    ''
    (
      if (lib.hasAttr "greetd/hyprland-monitor.conf" config.environment.etc) then
        "source = /etc/greetd/hyprland-monitor.conf"
      else
        ""
    )
  ];
}
