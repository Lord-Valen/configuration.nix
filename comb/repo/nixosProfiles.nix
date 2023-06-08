{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) lib;
in {
  bootstrap = {modulesPath, ...}: {
    imports = [
      (modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
    ];

    nix = {
      registry.nixpkgs.flake = nixpkgs;
      extraOptions = ''
        experimental-features = nix-command flakes recursive-nix
      '';
    };

    services.getty.helpLine = ''
      The "nixos" and "root" accounts have empty passwords.

      An ssh daemon is running. You then must set a password
      for either "root" or "nixos" with `passwd` or add an ssh key
      to /home/nixos/.ssh/authorized_keys be able to login.
    '';

    networking = {
      domain = "local";

      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };

      wireless = {
        enable = lib.mkForce false;
        iwd.enable = true;
      };
    };

    # https://www.freedesktop.org/software/systemd/man/systemd.network.html
    systemd.network.networks."boostrap-link-local" = {
      matchConfig = {Name = "en* wl* ww*";};
      networkConfig = {
        Description = "Link-local host bootstrap network";
        MulticastDNS = true;
        LinkLocalAddressing = "ipv6";
        DHCP = "yes";
      };
      address = [
        # fall back well-known link-local for situations where MulticastDNS is not available
        "fe80::47" # 47: n=14 i=9 x=24; n+i+x
      ];
      extraConfig = ''
        # Unique, yet stable. Based off the MAC address.
        IPv6LinkLocalAddressGenerationMode = "eui64"
      '';
    };
  };
}
