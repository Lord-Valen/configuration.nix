{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [arion docker-client];

  virtualisation = {
    docker.enable = false;
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.dnsname.enable = true;
    };
    arion = {backend = "podman-socket";};
  };
}
