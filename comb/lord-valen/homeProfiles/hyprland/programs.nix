{
  inputs,
  cell,
}: {
  eww = {
    package = inputs.nixpkgs.eww-wayland;
    enable = true;
    configDir = ./_eww;
  };
  wlogout = {
    enable = true;
    style = ./_wlogout/style.css;
  };
}
