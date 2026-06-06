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
  version = "5.13.2";

  src = fetchFromGitHub {
    owner = "SteamServerUI";
    repo = "StationeersServerUI";
    tag = "v${finalAttrs.version}";
    hash = "sha256-FC06KFfxmQX/iRyKfZiFKquSyOWdKyzi/DRqs42f0ag=";
  };

  vendorHash = "sha256-Cxv2aG+dhpmOtH99jZ0uFlXVEkNrcXvEwEjOd2TPZ2Y=";

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
