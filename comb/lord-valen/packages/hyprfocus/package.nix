{
  gcc13Stdenv,
  fetchFromGitHub,
  pkg-config,
  hyprland,
  meson,
  ninja,
  wlroots,
  lib,
}:
gcc13Stdenv.mkDerivation {
  pname = "hyprfocus";
  version = "unstable-2023-11-01";

  src = fetchFromGitHub {
    owner = "VortexCoyote";
    repo = "hyprfocus";
    rev = "ec3b45482f651c2b1f0e4df90a41d24a1afa5a74";
    hash = "sha256-JuUNQXUetKIUGGwzEA5dQmKtpFvYSZzG/IV373aKd6U=";
  };

  nativeBuildInputs = [
    pkg-config
    hyprland
    wlroots
  ];

  buildInputs = lib.foldr lib.remove hyprland.buildInputs [meson ninja];

  buildFlags = ["all"];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share
    install -Dm644 hyprfocus.so $out/lib/libhyprfocus.so

    runHook postInstall
  '';

  meta = with lib; {
    description = "A focus animation plugin for Hyprland inspired by Flashfocus";
    homepage = "https://github.com/VortexCoyote/hyprfocus";
    licence = with licences; [bsd3];
    maintainers = with maintainers; [lord-valen];
  };
}
