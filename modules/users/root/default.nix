{ lib, den, ... }:
{
  den.aspects.root = {
    includes = [
      den.aspects.base
      den.aspects.nushell
    ];

    user =
      { pkgs, ... }:
      {
        initialHashedPassword = "$6$rZhNhLxPNJx.lRBn$lXAcMr7CdFgjRcN4ZMlEai2QYWMoawm6pMKrd9oFHXgWks9KBkP3p7Afj/Djj1LnCDyXbLNT5IfVNjDEUzk1p0";
        shell = pkgs.nushell;
      };

    homeManager = {
      home = {
        stateVersion = lib.mkDefault "25.05";
        sessionPath = [ "$HOME/.local/bin" ];
      };
    };
  };
}
