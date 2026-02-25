{ config, ... }:
{
  flake.aspects.development = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ config.flake.modules.nixos.dynamic-derivations ];
        environment.systemPackages = with pkgs; [
          man-pages
          man-pages-posix
        ];
        documentation = {
          enable = true;
          dev.enable = true;
          man.generateCaches = true;
          # FIXME: https://github.com/nix-community/stylix/issues/
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
  };
}
