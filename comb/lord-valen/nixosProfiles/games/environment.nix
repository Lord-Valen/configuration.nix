{
  inputs,
  cell,
}: {
  systemPackages = with inputs.nixpkgs; [
    protonup-ng
    protontricks
    heroic
    lutris
  ];
}
