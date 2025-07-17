{ lib, ... }:
{
  flake.modules.nixos.shell = {
    programs.zoxide = {
      enable = true;
      options = lib.cli.toGNUCommandLine { } { cmd = "cd"; };
    };
  };
}
