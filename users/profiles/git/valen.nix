{ config, lib, pkgs, ... }:

{
  programs.git = {
    userName = "Lord-Valen";
    userEmail = "lord_valen@protonmail.com";

    signing = {
      key = null;
      signByDefault = true;
    };
  };
}
