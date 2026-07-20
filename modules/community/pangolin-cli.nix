{
  den.aspects.pangolin-cli.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pangolin-cli
      ];
    };
}
