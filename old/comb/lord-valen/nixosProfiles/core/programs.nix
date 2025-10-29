{
  nix-ld.enable = true;
  git.enable = true;
  nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 2 --keep-since 2d";
    };
  };
}
