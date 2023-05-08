{
  inputs,
  cell,
}: {
  eww = {
    package = inputs.nixpkgs.eww-wayland;
    enable = true;
    configDir = ./_eww;
  };
}
