{ den, ... }:
{
  den.aspects.shell = {
    includes = with den.aspects; [
      fonts
      comma
    ];
    homeManager =
      { pkgs, ... }:
      {
        programs.bash.enable = true;

        home.packages = with pkgs; [
          ripgrep
          bottom
          carapace
          bat
          ouch
        ];
      };
  };
}
