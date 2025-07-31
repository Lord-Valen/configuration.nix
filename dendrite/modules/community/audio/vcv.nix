{
  flake.modules.homeManager.vcv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        vcv-rack
        cardinal
      ];
      home.file.".Rack2" = {
        source = ./_Rack2.d;
        recursive = true;
      };
    };
}
