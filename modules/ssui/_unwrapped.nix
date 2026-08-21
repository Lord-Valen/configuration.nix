# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{
  buildGoModule,
  fetchFromGitHub,
  lib,
  makeBinaryWrapper,
  steamcmd,
}:
buildGoModule (finalAttrs: {
  pname = "ssui-unwrapped";
  version = "5.14.0";

  src = fetchFromGitHub {
    owner = "SteamServerUI";
    repo = "StationeersServerUI";
    tag = "${finalAttrs.version}";
    hash = "sha256-WLGZ09PXCDtNJSkYK/F/OaxSWHJkMt55s+z1giPnBl4=";
  };

  vendorHash = "sha256-wojDO8Mu4w9ZMaSA4StoXhdQ8UlaA9YzWumJaVf1GB0=";

  nativeBuildInputs = [ makeBinaryWrapper ];
  buildInputs = [ steamcmd ];

  patches = [
    ./_patches/systemSteamcmd.patch
  ];

  postPatch = ''
    # Force the application to use our steamcmd.
    substituteInPlace src/steamcmd/steamcmd.go \
      --replace-fail "./steamcmd" "${steamcmd}"
  '';

  meta = {
    description = "Web-based server management interface for Stationeers dedicated servers";
    homepage = "https://steamserverui.github.io";
    mainProgram = "StationeersServerUI";
    license = with lib.licenses; [ unfree ];
    maintainers = with lib.maintainers; [ lord-valen ];
  };
})
