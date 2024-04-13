{
  inputs,
  cell,
  pkgs,
  lib,
}:
let
  inherit (cell) packages;
in
rec {
  user = {
    services =
      let
        hyprlandChild =
          attrset:
          lib.recursiveUpdate {
            Unit = {
              BindsTo = [ "hyprland-session.target" ];
              After = [ "hyprland-session.target" ];
            };
          } attrset;
      in
      lib.mapAttrs (_: value: hyprlandChild value) {
        wpaperd =
          let
            package = pkgs.wpaperd;
          in
          {
            Unit.Description = package.meta.description;

            Service.ExecStart = ''${lib.getExe' package "wpaperd"} --no-daemon'';
          };
      };

    targets.hyprland-session.Unit.Wants = lib.mapAttrsToList (name: _: "${name}.service") user.services;
  };
}
