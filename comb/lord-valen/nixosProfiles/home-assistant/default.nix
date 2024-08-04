{ cell }:
{
  imports = [ cell.nixosProfiles.nginx ];
  services.nginx = {
    virtualHosts.home = {
      serverAliases = [ "home.home *.home.home" ];
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://localhost:8123";
        proxyWebsockets = true;
      };
    };
  };
  services.home-assistant = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [ ];
    extraComponents = [
      "lidarr"
      "sonarr"
      "radarr"
    ];
    config = {
      homeassistant = {
        unit_system = "metric";
        temperature_unit = "C";
      };
      http = {
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
        use_x_forwarded_for = true;
      };
      default_config = { };

      roomba = { };
      wiz = { };
      zwave_js = { };
      zha = {
        zigpy_config.ota.z2m_remote_index = "https://raw.githubusercontent.com/Koenkk/zigbee-OTA/master/index.json";
      };
    };
  };
}
