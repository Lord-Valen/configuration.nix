{
  inputs,
  cell,
}: {
  systemPackages = with inputs.nixpkgs; [
    pavucontrol
    carla
    helvum
  ];
}
