{ lib, den, ... }:
{
  den.aspects.sioux = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.aspects.base
    ];

    user =
      { pkgs, ... }:
      {
        initialHashedPassword = "$y$j9T$1ttrJXMNjeH62Or9EOGfG/$pdm3JxpOroaC5BaqDN/79xKEvlUXW5fjBMGKPTFqeyA";
        shell = pkgs.nushell;
      };

    homeManager = {
      home = {
        stateVersion = lib.mkDefault "24.11";
        sessionPath = [ "$HOME/.local/bin" ];
      };
    };
  };
}
