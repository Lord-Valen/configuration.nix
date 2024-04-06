{
  inputs,
  cell,
  pkgs,
  lib,
}:
{
  programs.wlogout = {
    enable = true;
    layout =
      let
        loginctl = lib.getExe' pkgs.systemd "loginctl";
        systemctl = lib.getExe' pkgs.systemd "systemctl";
      in
      [
        {
          label = "logout";
          text = "Logout";
          action = "${loginctl} terminate-user $USER";
          keybind = "l";
        }
        {
          label = "suspend";
          text = "Suspend";
          action = "${systemctl} suspend";
          keybind = "s";
        }
        {
          label = "shutdown";
          text = "Shutdown";
          action = "${systemctl} poweroff";
          keybind = "p";
        }
        {
          label = "hybrid";
          text = "Hybrid Sleep";
          action = "${systemctl} hybrid-sleep";
          keybind = "b";
        }
        {
          label = "reboot";
          text = "Reboot";
          action = "${systemctl} reboot";
          keybind = "r";
        }
        {
          label = "hibernate";
          text = "Hibernate";
          action = "${systemctl} hibernate";
          keybind = "h";
        }
      ];
    style =
      let
        wlogout = config.programs.wlogout.package;
      in
      ''
        * {
          background-image: none;
        }

        window {
          background-color: #0c0a20;
        }

        button {
          color: #f2f3f7;
          background-color: #1f1147;
          border-style: solid;
          border-width: 2px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:focus,
        button:active,
        button:hover {
          background-color: #3700b3;
          outline-style: none;
        }

        #logout {
          background-image: image(url("${wlogout}/share/wlogout/icons/logout.png"));
        }

        #suspend {
          background-image: image(url("${wlogout}/share/wlogout/icons/suspend.png"));
        }

        #hybrid {
          background-image: image(url("${wlogout}/share/wlogout/icons/suspend.png"));
        }

        #hibernate {
          background-image: image(url("${wlogout}/share/wlogout/icons/hibernate.png"));
        }

        #shutdown {
          background-image: image(url("${wlogout}/share/wlogout/icons/shutdown.png"));
        }

        #reboot {
          background-image: image(url("${wlogout}/share/wlogout/icons/reboot.png"));
        }
      '';
  };
}
