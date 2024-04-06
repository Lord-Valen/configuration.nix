{
  inputs,
  cell,
  pkgs,
}:
{
  home.packages = with pkgs; [ vcv-rack ];

  home.file.".Rack2" = {
    source = ./_Rack2.d;
    recursive = true;
  };
}
