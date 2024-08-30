{
  programs.qutebrowser = {
    enable = true;
    settings = {
      hints.chars = "artgmneio";
    };
    searchEngines = {
      gh = "https://github.com/search?q={}&type=repositories";
      np = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
      nd = "https://discourse.nixos.org/search?q={}";
      nw = "https://wiki.nixos.org/w/index.php?search={}";
      nppr = "https://nixpk.gs/pr-tracker.html?pr={}";
      yt = "https://www.youtube.com/results?search_query={}";
      wk = "https://en.wikipedia.org/w/index.php?search={}";
      aa = "https://annas-archive.org/search?q={}";
      sep = "https://plato.stanford.edu/search/searcher.py?query={}";
      noog = "https://noogle.dev/q?term={}";
      npm = "https://www.npmjs.com/search?q={} ";
    };
    keyBindings = {
      normal = {
        m = "scroll left";
        n = "scroll down";
        e = "scroll up";
        i = "scroll right";
        M = "back";
        N = "tab-next";
        E = "tab-prev";
        I = "forward";
        K = "search-prev";
        k = "search-next";
        l = "undo";
        u = "mode-enter insert";
      };
      caret = {
        m = "move-to-prev-char";
        n = "move-to-next-line";
        e = "move-to-prev-line";
        i = "move-to-next-char";
        M = "scroll left";
        N = "scroll down";
        E = "scroll up";
        I = "scroll right";
        f = "move-to-end-of-word";
      };
    };
  };
}
