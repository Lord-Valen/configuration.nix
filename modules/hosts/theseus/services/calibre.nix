{
  den.aspects.servarr.provides.theseus.nixos = {
    services.caddy.virtualHosts = {
      "calibre.laughing-man.xyz".extraConfig = ''
        @not_private not remote_ip private_ranges
        respond @not_private "Access denied" 403 {
          close
        }

        reverse_proxy http://localhost:8080
      '';
    };
  };
}
