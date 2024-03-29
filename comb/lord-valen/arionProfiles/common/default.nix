{ inputs, cell }:
let
  inherit (inputs) arion;
in
{
  imports = [ arion.nixosModules.arion ];

  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    arion = {
      backend = "podman-socket";
    };
  };
}
