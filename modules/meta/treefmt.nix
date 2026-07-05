{ inputs, ... }:
{
  imports = [
    (inputs.treefmt-nix.flakeModule or { })
  ];

  perSystem =
    { config, ... }:
    {
      treefmt = {
        programs = {
          nixfmt.enable = true;
          deadnix.enable = true;
          # nixf-diagnose.enable = true; # FIXME: Upsteam needs to allow me to ignore linting errors.
        };
        settings.global.excludes = [
          "LICENSE"
          "*.lock"
          ".envrc"
        ];
      };

      devshells.default = {
        packages = [ config.treefmt.build.wrapper ];
      };
    };
}
