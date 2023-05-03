{
  inputs,
  cell,
}: {
  home.packages = with inputs.nixpkgs; [
    nushell
    socat
  ];
  programs.eww = {
    enable = true;
    configDir = ./_eww;
  };
}
