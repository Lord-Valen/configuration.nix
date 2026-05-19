{ lib, ... }:
{
  den.aspects.shell.homeManager = {
    programs.zoxide = {
      enable = true;
      options = lib.cli.toGNUCommandLine { } { cmd = "cd"; };
    };
  };
}
