{
  den.aspects.servarr.provides.theseus.nixos = { config, ... }: {

    sops.secrets.cloudflared-tunnel = {
      sopsFile = ../secrets/cloudflared-tunnel.json;
      format = "json";
      key = "";
    };

    services = {
      cloudflared.enable = true;
      cloudflared.tunnels.main = {
        credentialsFile = config.sops.secrets.cloudflared-tunnel.path;
        default = "http_status:404";
        originRequest = {
          disableChunkedEncoding = true;
        };
      };
    };
  };
}
