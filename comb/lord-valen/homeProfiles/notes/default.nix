{ pkgs }:
{
  home.packages = with pkgs; [
    logseq
    xournalpp
  ];
}
