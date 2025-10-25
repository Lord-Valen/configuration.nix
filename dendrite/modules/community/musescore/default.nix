{
  flake.modules.homeManager.musescore =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # FIXME: "https://nixpk.gs/pr-tracker.html?pr=454915"
        #musescore
        muse-sounds-manager
      ];
    };
}
