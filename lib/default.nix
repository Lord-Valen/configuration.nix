{ inputs, lib, pkgs, ... }:

let
  inherit (lib) makeExtensible attrValues foldr;
  inherit (modules) recImport;

  modules = import ./modules.nix { inherit lib; };

  mylib = makeExtensible (self: with self; recImport ./.);
in mylib.extend (self: super: foldr (a: b: a // b) { } (attrValues super))
