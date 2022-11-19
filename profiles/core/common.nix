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
      nd = "n develop";
      nsh = "n shell";
      ns = "n search --no-update-lock-file";
      nsn = "ns nixos";
      nso = "ns override";
      np = "n profile";
      npl = "np list";
      npi = "np install";
      npr = "np remove";
      nf = "n flake";
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
    };
  };

  fonts.fonts = with pkgs; [powerline-fonts dejavu_fonts];

  nix = {
    # Improve nix store disk usage
    gc.automatic = true;

    # Prevents impurities in builds
    useSandbox = true;

    # Give root user and wheel group special Nix privileges.
    trustedUsers = ["root" "@wheel"];

    # Generally useful nix option defaults
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };
}
