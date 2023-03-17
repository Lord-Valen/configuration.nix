{
  imports = [./common.nix];
  virtualisation.arion.projects.pihole.settings = let
    appdir = "/docker/appdata/";
    env = {
      TZ = "Canada/Eastern";
      PIHOLE_DNS = "9.9.9.9;149.112.112.112";
      FTLCONF_LOCAL_IPV4 = "192.18.250.41";
    };
    restart = "unless-stopped";
  in {
    config.services.pihole.service = {
      useHostStore = true;
      environment = env;
      restart = restart;
      image = "pihole/pihole:latest";
      volumes = [(appdir + "pihole/pihole:/etc/pihole") (appdir + "pihole/dnsmasq:/etc/dnsmasq.d")];
      ports = ["53:53" "80:80"];
    };
  };
}
