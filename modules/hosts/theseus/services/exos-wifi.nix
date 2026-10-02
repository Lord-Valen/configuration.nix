{ inputs, ... }: {
  den.aspects.exos-wifi.provides.theseus = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        nixpkgs.overlays = [ inputs.exos-wifi.overlay ];

        sops.secrets.router_secret = {
          sopsFile = ../secrets/exos-wifi.yaml;
        };

        sops.templates.exos-wifi.content = ''
          ROUTER_PASSWORD = ${config.sops.placeholder.router_secret}
        '';

        systemd.services."exos-wifi@" = {
          after = [ "network.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${lib.getExe pkgs.exos-wifi} %I";
            EnvironmentFile = config.sops.templates.exos-wifi.path;
            # Make sure we try again if DNS fails or something
            Restart = "on-failure";
            RestartSec = "5min";
            RestartSteps = "6";
          };
        };

        systemd.timers.exos-wifi-off = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "*-*-* 22:00:00";
            Persistent = true;
            Unit = "exos-wifi@off.service";
          };
        };

        systemd.timers.exos-wifi-on = {
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "*-*-* 06:00:00";
            Persistent = true;
            Unit = "exos-wifi@on.service";
          };
        };
      };
  };
}
