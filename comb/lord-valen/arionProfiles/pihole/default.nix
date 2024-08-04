{ inputs, cell }:
let
  inherit (cell.arionProfiles) common;
in
{
  imports = [
    common
    cell.nixosProfiles.nginx
  ];

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };

  services.nginx.virtualHosts.hole = {
    serverAliases = [ "hole.home *.hole.home" ];
    locations."/" = {
      proxyPass = "http://localhost:4013";
    };
  };

  virtualisation.arion.projects.pihole.settings =
    let
      appdir = "/docker/appdata/";
      env = {
        TZ = "Canada/Eastern";
        VIRTUAL_HOST = "hole.home";
      };
      restart = "unless-stopped";
    in
    {
      config.services.pihole.service = {
        useHostStore = true;
        environment = env;
        restart = restart;
        image = "pihole/pihole:latest";
        volumes = [
          (appdir + "pihole/pihole:/etc/pihole")
          (appdir + "pihole/dnsmasq:/etc/dnsmasq.d")
        ];
        ports = [
          "53:53"
          "4013:80"
        ];
      };
    };
}
