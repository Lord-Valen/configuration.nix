{
  inputs,
  cell,
  pkgs,
  lib,
}:
let
  # FIXME: attribute 'pkgs' missing
  pkgs = inputs.nixpkgs;
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

        # hypr-empty = let
        #   package = packages.hypr-empty;
        # in {
        #   Unit.Description = package.meta.description;

        #   Service.ExecStart = ''${lib.getExe package}'';
        # };

        # deflisten won't find the script for mysterious reasons
        # eww = let
        #   package = pkgs.eww-wayland;
        #   inherit (pkgs) nushell hyprland socat;
        # in {
        #   Unit.Description = package.meta.description;
        #   Unit.User = "lord-valen";

        #   Service = let
        #     exe = lib.getExe package;
        #   in {
        #     Environment = ["PATH=${lib.makeBinPath [nushell socat hyprland]}:$PATH"];
        #     ExecStart = ''${exe} daemon --no-daemonize'';
        #     ExecStartPost = ''${exe} open bar'';
        #   };
        # };
      };

    targets.hyprland-session.Unit.Wants = lib.mapAttrsToList (name: _: "${name}.service") user.services;
  };
}
