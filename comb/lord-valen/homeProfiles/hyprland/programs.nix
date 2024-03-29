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
      indicator = "b56cd2";
      fade-in = 0.5;
      effect-blur = "7x5";
    };
  };
}
