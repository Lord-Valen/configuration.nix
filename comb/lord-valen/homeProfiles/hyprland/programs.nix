{
  inputs,
  cell,
  config,
  pkgs,
}:
{
  swaylock = {
    package = pkgs.swaylock-effects;
    enable = true;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      fade-in = 0.5;
      effect-blur = "7x5";
    };
  };
}
