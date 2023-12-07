{
  programs.zathura = {
    enable = true;
    mappings = {
      m = "scroll left";
      n = "scroll down";
      N = "navigate next";
      E = "navigate previous";
      e = "scroll up";
      i = "scroll right";

      k = "search forward";
      K = "search packward";

      h = "mark_add";
    };
    options = {
      adjust-open = "width";
      recolor = true;
    };
  };
}
