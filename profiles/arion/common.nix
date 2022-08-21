{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ arion docker-client ];

  virtualisation.arion = { backend = "podman-socket"; };
}
