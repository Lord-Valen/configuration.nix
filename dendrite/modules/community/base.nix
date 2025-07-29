{ lib, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
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
