{ config, den, ... }:
let
  # No services.gerbil.package option exists - the module hardcodes
  # pkgs.fosrl-gerbil - so overlaying is the only way to swap it.
  fosrlOverlay = config.flake.overlays.fosrl-unstable;
in
{
  den.aspects.pangolin.provides.theseus = {
    nixos =
      { config, lib, ... }:
      {
        nixpkgs.overlays = [ fosrlOverlay ];

        sops.secrets.pangolin_server_secret = {
          sopsFile = ./../secrets/pangolin.yaml;
          key = "server_secret";
        };
        sops.templates.pangolin-env.content = ''
          SERVER_SECRET=${config.sops.placeholder.pangolin_server_secret}
        '';

        # DNS-only: Gerbil reuses this domain as its own base_endpoint, and
        # Cloudflare can't proxy raw WireGuard traffic.
        services.cloudflare-dyndns = {
          domains = [ "*.laughing-man.xyz" ];
          proxied = lib.mkForce false;
        };

        # Traefik's own Cloudflare token for the DNS-01 challenge.
        sops.templates.traefik-cloudflare-env.content = ''
          CF_DNS_API_TOKEN=${config.sops.placeholder.cloudflare_secret}
        '';
        services.traefik.environmentFiles = [ config.sops.templates.traefik-cloudflare-env.path ];

        services.pangolin = {
          enable = true;
          openFirewall = true;
          baseDomain = "laughing-man.xyz";
          letsEncryptEmail = "lord_valen@proton.me";
          environmentFile = config.sops.templates.pangolin-env.path;
          settings.server.external_port = 3005; # 3000 collides with Grafana
          # Wildcard via DNS-01: private resources need cert issuance that
          # doesn't require public HTTP-01 reachability.
          dnsProvider = "cloudflare";
          settings.domains.domain1.prefer_wildcard_cert = true;
        };

        # openFirewall only opens 51820, but Gerbil's actual WireGuard/hole-punch
        # listener is 21820 - not exposed as a nix option, hardcoded in gerbil
        # itself, and missing from the module's openFirewall implementation.
        networking.firewall.allowedUDPPorts = [ 21820 ];
      };
  };
}
