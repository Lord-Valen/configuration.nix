{ lib, inputs, ... }:
{
  flake.modules.nixos.base =
    { pkgs, config, ... }:
    {
      time.timeZone = lib.mkDefault "Canada/Eastern";
      boot.tmp.useTmpfs = true;
      nix = {
        registry =
          let
            inherit (inputs.nixpkgs-registry) registry;
          in
          registry
          // {
            unstable = registry.nixos-unstable;
            configuration.to = {
              type = "github";
              owner = "Lord-Valen";
              repo = "configuration.nix";
            };
          };

        settings = {
          trusted-users = [
            "root"
            "@wheel"
          ];

          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          min-free = 1073741824;
          fallback = true;
        };
      };

      environment.systemPackages = with pkgs; [
        binutils
        coreutils
        dnsutils
        inetutils
        iputils
        usbutils
        util-linux
        pciutils
        gptfdisk
        dosfstools
        ripgrep
        fd
        file
        whois
        bottom
      ];
      hardware = {
        graphics.enable32Bit = lib.mkDefault true;
        enableRedistributableFirmware = lib.mkDefault true;
      };
      programs = {
        nix-ld.enable = true;
        git.enable = true;
        nh = {
          enable = true;
          clean = {
            enable = true;
            dates = "weekly";
            extraArgs = "--keep 2 --keep-since 2d";
          };
        };
      };
      services = {
        openssh = {
          enable = true;
          settings.PasswordAuthentication = false;
        };
        earlyoom.enable = true;
        udisks2.enable = true;
      };
    };
}
