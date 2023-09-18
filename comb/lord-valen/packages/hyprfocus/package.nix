{
  stdenv,
  fetchFromGitHub,
  pkg-config,
  hyprland,
  meson,
  ninja,
  wlroots,
  lib,
}:
stdenv.mkDerivation {
  pname = "hyprfocus";
  version = "unstable-2023-06-12";

  src = fetchFromGitHub {
    owner = "VortexCoyote";
    repo = "hyprfocus";
    rev = "69f3f23e90f1b9a6525a860c19ad2b17762f45f3";
    hash = "sha256-Ay6bWvDPkbgoOzlfs9WS2gZZGfhvBay+0k+niXUuHb8=";
  };

  nativeBuildInputs =
    (lib.foldr lib.remove hyprland.buildInputs [meson ninja])
    ++ [
      pkg-config
      hyprland
      wlroots
    ];

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
