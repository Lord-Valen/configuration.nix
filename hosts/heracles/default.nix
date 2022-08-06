{ config, pkgs, lib, hm, ... }:

with lib;

{
  imports = [ ./hardware-configuration.nix ];

  modules = {
    emacs = {
      enable = true;
      doom.enable = true;
      academicWriting.enable = true;
    };
    pipewire.enable = true;
    x11 = {
      enable = true;
      xmonad.enable = true;
    };
    networking.enable = true;
    tidal.enable = true;
    monero.enable = true;
    docker.enable = true;
    games.enable = true;
    ipfs.enable = true;
    vm.enable = true;
    dev.haskell.enable = true;
    syncthing.enable = true;
  };

  time.timeZone = "Canada/Eastern";
  i18n.defaultLocale = "en_CA.UTF-8";

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    printing.enable = true;
    openssh.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
    syncthing = {
      folders = {
        "photos" = {
          id = "sm-g950w_7ywz-photos";
          path = "/data/oracle-photos";
          devices = [ "oracle" ];
        };
        "books" = {
          id = "fheng-o2wyn";
          path = "/data/media/books";
          type = "sendonly";
          devices = [ "oracle" ];
        };
        "music" = {
          id = "zfumc-pfy38";
          path = "/data/media/music";
          type = "sendonly";
          devices = [ "oracle" ];
        };
      };
    };
  };

  home-manager.users."${config.user}".home.packages = with pkgs; [
    brave
    discord
    vscode
    ghc
  ];

  system.stateVersion = "22.05";
}
