{
  enable = true;
  userDirs = {
    enable = true;
    createDirectories = true;
  };
  configFile."nixpkgs/config.nix".source = ./_config.nix;
}
