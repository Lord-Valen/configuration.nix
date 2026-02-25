{ inputs, ... }:
{
  flake.aspects.base.homeManager =
    { lib, ... }:
    {
      manual = {
        html.enable = lib.mkDefault false;
        json.enable = lib.mkDefault false;
        manpages.enable = lib.mkDefault false;
      };
    };
  flake.aspects.base.nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      documentation.enable = lib.mkDefault false;
      boot.tmp.useTmpfs = true;

      nix.settings = {
        auto-optimise-store = true;
        keep-build-log = lib.mkDefault false;
        keep-derivations = lib.mkDefault false;
        min-free = 1073741824;
        pure-eval = true;
        trusted-users = lib.singleton "root";
      };
      nix.gc.automatic = lib.mkDefault true;

      hardware.enableRedistributableFirmware = lib.mkDefault true;
      services = {
        openssh = {
          enable = true;
          settings.PasswordAuthentication = false;
        };
        earlyoom.enable = true;
      };
    };
  flake.aspects.pc.nixos =
    { lib, pkgs, ... }:
    {
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

      nix.registry =
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
      nix.settings = {
        trusted-users = lib.singleton "@wheel";
        fallback = true;
      };
      nix.gc.automatic = lib.mkForce false;

      hardware.graphics.enable32Bit = lib.mkDefault true;

      programs.nix-ld.enable = true;
      programs.git.enable = true;
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          dates = "weekly";
          extraArgs = "--keep 2 --keep-since 2d";
        };
      };

      services.udisks2.enable = true;
    };
}
