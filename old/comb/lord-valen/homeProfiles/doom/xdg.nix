{ pkgs, config }:
{
  configFile."doom" = {
    recursive = true;
    source = ./_doom.d;
  };
  configFile."doom/extraConfig.el" = {
    text = config.programs.emacs.extraConfig;
  };
}
