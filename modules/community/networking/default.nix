{
  flake.modules.nixos.networking =
    { pkgs, ... }:
    {
      networking = {
        enableIPv6 = true;
        networkmanager = {
          enable = true;
        };
      };

      environment.systemPackages = with pkgs; [
        wget
        curl
        nmap
        nethogs
      ];
    };
}
