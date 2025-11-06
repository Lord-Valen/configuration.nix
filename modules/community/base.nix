{ lib, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      time.timeZone = lib.mkDefault "Canada/Eastern";
      boot.tmp.cleanOnBoot = true;
      nix.settings = {
        trusted-users = [
          "root"
          "@wheel"
        ];

        download-buffer-size = 524288000;

        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        min-free = 1073741824;
        fallback = true;
      };
      nix.registry =
        let
          me = repo: {
            inherit repo;
            owner = "Lord-Valen";
            type = "github";
          };
        in
        rec {
          unstable.to = {
            type = "tarball";
            url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
          };
          configuration.to = me "configuration.nix";
          templates.to = me "nix-templates";
          devshells.to = templates.to;
        };

      environment.systemPackages = with pkgs; [
        binutils
        coreutils
        dnsutils
        inetutils
        iputils
        usbutils
        utillinux
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
