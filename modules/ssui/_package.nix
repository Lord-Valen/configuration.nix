# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{
  callPackage,
  lib,
  ssui-unwrapped ? callPackage ./_unwrapped.nix { },
  symlinkJoin,
  writeShellScriptBin,
}:
let
  wrapper = writeShellScriptBin ssui-unwrapped.meta.mainProgram ''
    # Set up the directory structure for steamcmd and ssui to work together.
    mkdir -p .local/share/Steam
    mkdir -p .local/share/steamapps
    ln -sf .local/share/Steam Steam
    ln -sf .local/share/steamapps steamapps

    # Prevent ssui from trying to change to the executable's directory, which is read-only.
    exec ${lib.getExe ssui-unwrapped} --NoSanityCheck "$@"
  '';
in
symlinkJoin {
  pname = lib.replaceStrings [ "-unwrapped" ] [ "" ] ssui-unwrapped.pname;
  inherit (ssui-unwrapped) version;

  paths = [
    wrapper
    ssui-unwrapped
  ];

  meta = {
    inherit (ssui-unwrapped.meta) description homepage maintainers mainProgram;
    license = with lib.licenses; [mit];
  };
}
