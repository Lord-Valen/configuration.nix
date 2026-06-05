{
  den.aspects.notes.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        logseq
        xournalpp
      ];
    };
}
