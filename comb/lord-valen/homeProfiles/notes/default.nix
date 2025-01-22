{ pkgs }:
{
  home.packages = with pkgs; [
    logseq
    obsidian
    xournalpp
  ];
}
