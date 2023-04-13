{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    binutils
    coreutils
    dnsutils
    nmap
    curl
    git
    direnv
    bottom
    jq
    nix-index
    ripgrep
    fd
    whois
    dosfstools
    gptfdisk
    iputils
    usbutils
    utillinux
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      sandbox = true;

      trusted-users = ["root" "@wheel"];
      allowed-users = ["@wheel"];

      auto-optimise-store = true;
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };

  # For rage encryption, all hosts need a ssh key pair
  services.openssh = {
    enable = true;
    openFirewall = lib.mkDefault false;
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;
}
