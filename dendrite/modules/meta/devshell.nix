{
  inputs,
  ...
}:
{
  imports = [ inputs.devshell.flakeModule ];
  flake-file.inputs.devshell.url = "github:numtide/devshell";
  perSystem =
    { lib, ... }:
    {
      devshells.default = {
        env = [
          {
            name = "NH_FlAKE";
            eval = "$PRJ_ROOT";
          }
        ];
        commands =
          let
            mkCategory = category: attrs: attrs // { inherit category; };
            nixCategory = mkCategory "nix";
          in
          lib.map nixCategory [
            {
              name = "boot";
              help = "Switch boot configuration";
              command = ''nh os boot "$@"'';
            }
            {
              name = "build";
              help = "Build configuration";
              command = ''nh os build "$@"'';
            }
            {
              name = "switch";
              help = "Switch configuration";
              command = ''nh os switch "$@"'';
            }
            {
              name = "test";
              help = "Test configuration";
              command = ''nh os test "$@"'';
            }
            {
              name = "dry";
              help = "Dry activate configuration";
              command = ''nh os switch --dry "$@"'';
            }
            {
              name = "check";
              help = "Run flake checks";
              command = ''nix flake check "$PRJ_ROOT" "$@"'';
            }
            {
              name = "write-flake";
              help = "Run write-flake script";
              command = ''nix run "$PRJ_ROOT#write-flake" "$@"'';
            }
            {
              name = "update";
              help = "Update flake inputs";
              command = ''nix flake update "$PRJ_ROOT" "$@"'';
            }
          ];
      };
    };
}
