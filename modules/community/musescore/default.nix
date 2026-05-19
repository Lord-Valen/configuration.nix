{
  den.aspects.musescore.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        musescore
        muse-sounds-manager
      ];
    };
}
