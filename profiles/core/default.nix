{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) fileContents;
in {
  # Sets binary caches which speeds up some builds
  imports = [../cachix];

  environment = {
    systemPackages = with pkgs; [
      binutils
      coreutils
      dnsutils
      nmap
      curl
      git
      direnv
      bottom
      jq
      manix
      tealdeer
      nix-index
      ripgrep
      fd
      skim
      whois
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux
    ];

    # Starship is a fast and featureful shell prompt
    # starship.toml has sane defaults that can be changed there
    shellInit = ''
      export STARSHIP_CONFIG=${
        pkgs.writeText "starship.toml"
        (fileContents ./starship.toml)
      }
    '';

    shellAliases = let
      ifSudo = lib.mkIf config.security.sudo.enable;
    in {
      # quick cd
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";

      # git
      g = "git";

      # grep
      grep = "rg";
      gi = "grep -i";

      # internet ip
      myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

      # nix
      n = "nix";
      nepl = "n repl '<nixpkgs>'";
      nr = "n run";
      nd = "n develop";
      ns = "n shell";
      np = "n profile";
      npl = "np list";
      npi = "np install";
      npr = "np remove";
      npu = "np upgrade";
      npua = "npu '.*'";
      nf = "n flake";
      nfu = "nf update";
      nfck = "nf check";

      # manix
      mn = ''
        manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
      '';

      # bottom
      top = "btm";

      # sudo
      s = ifSudo "sudo -E ";
      si = ifSudo "sudo -i";
      se = ifSudo "sudoedit";

      # fix nixos-option for flake compat
      nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat";

      # systemd
      ctl = "systemctl";
      stl = ifSudo "s systemctl";
      utl = "systemctl --user";
      ut = "systemctl --user start";
      un = "systemctl --user stop";
      up = ifSudo "s systemctl start";
      dn = ifSudo "s systemctl stop";
      jtl = "journalctl";
    };
  };

  fonts.fonts = with pkgs; [powerline-fonts dejavu_fonts];
  fonts.fontconfig.defaultFonts = {
    monospace = ["DejaVu Sans Mono for Powerline"];
    sansSerif = ["DejaVu Sans"];
  };

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
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };

  programs.bash = {
    # Enable starship
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
    '';
    # Enable direnv, a tool for managing shell environments
    interactiveShellInit = ''
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
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
