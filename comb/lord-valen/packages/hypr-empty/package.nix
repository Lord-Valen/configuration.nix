{
  rustPlatform,
  fetchFromGitHub,
  hyprland,
  lib,
}:
rustPlatform.buildRustPackage rec {
  pname = "hypr-empty";
  version = "unstable-2023-07-19";

  src = fetchFromGitHub {
    owner = "nate-sys";
    repo = "hypr-empty";
    rev = "e3004489ed07a60ca74e5e318891d34816caa847";
    hash = "sha256-vCMDQ8kD9TKuh8aWZjyZ6YiaomrLLJM1ocKySmqZ3/4=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "hyprland-0.3.1" = "sha256-6UXvkDBdGNLrCEQOJY3By7k8wjf1HI52EDh1Iu1+M4I=";
    };
  };

  meta = with lib; {
    description = "Spawn a runner when switching to an empty workspace on Hyprland";
    homepage = "https://github.com/nate-sys/hypr-empty";
    mainProgram = "hypr-empty";
    license = with licenses; [bsd3];
    maintainers = with maintainers; [lord-valen];
  };
}
