{
  flake.modules.homeManager.notes =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        logseq
        xournalpp
      ];
    };
}
