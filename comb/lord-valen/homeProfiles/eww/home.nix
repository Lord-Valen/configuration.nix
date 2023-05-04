{
  inputs,
  cell,
}: {
  packages = with inputs.nixpkgs; [
    nushell
    socat
  ];
}
