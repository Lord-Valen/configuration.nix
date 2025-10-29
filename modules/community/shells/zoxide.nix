{ lib, ... }:
{
  flake.modules.homeManager.shell = {
    programs.zoxide = {
      enable = true;
      options = lib.cli.toGNUCommandLine { } { cmd = "cd"; };
    };
  };
}
