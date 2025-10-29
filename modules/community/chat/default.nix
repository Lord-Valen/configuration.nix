{
  config,
  ...
}:
let
  inherit (config.flake) modules;
in
{
  flake.modules.homeManager.chat = {
    imports = with modules.homeManager; [
      discord
      matrix
    ];
  };
}
