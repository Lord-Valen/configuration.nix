{
  inputs,
  cell,
  config,
}:
{
  swaylock = {
    package = inputs.nixpkgs.swaylock-effects;
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
