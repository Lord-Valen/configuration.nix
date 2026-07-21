{ den, ... }:
{
  den.aspects.development = {
    includes = with den.aspects; [ dynamic-derivations ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          man-pages
          man-pages-posix
        ];
        documentation = {
          enable = true;
          dev.enable = true;
          man.cache.enable = true;
          # FIXME: https://github.com/nix-community/stylix/issues/98
          # nixos.includeAllModules = true;
        };
        nix.settings = {
          keep-build-log = true;
          keep-derivations = true;
          keep-outputs = true;
        };
      };

    homeManager =
      { pkgs, ... }:
      {
        manual = {
          html.enable = true;
          json.enable = true;
          manpages.enable = true;
        };
        home.packages = with pkgs; [
          devenv
          nixtamal
        ];
        home.sessionPath = [ "$HOME/.local/bin" ];
        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        programs.git.enable = true;
        programs.jujutsu = {
          enable = true;
          ediff = false;
        };
      };

    provides.lord-valen.includes = with den.aspects; [ development ];

    provides.lord-valen = {
      homeManager =
        { config, pkgs, ... }:
        {
          home.packages = with pkgs; [
            reuse
            jq
          ];
          programs.jujutsu.settings = {
            user = {
              inherit (config.programs.git.settings.user) name email;
            };
            ui.default-command = "log";
            signing = {
              behaviour = "drop";
              backend = "ssh";
              key = "~/.ssh/id_ed25519.pub";
            };
            git.sign-on-push = true;
          };
          programs.git = {
            settings = {
              user = {
                name = "Lord-Valen";
                email = "lord_valen@protonmail.com";
              };
              github.user = "Lord-Valen";
              gitlab.user = "Lord-Valen";
              init.defaultBranch = "main";
              merge.conflictStyle = "zdiff3";
              fetch = {
                prune = true;
                pruneTags = true;
              };
              pull.rebase = true;
              push = {
                autoSetupRemote = true;
                default = "current";
              };
              remote.pushDefault = "Lord-Valen";
            };
            signing = {
              signByDefault = true;
              format = "ssh";
            };
          };
        };
    };
  };
}
