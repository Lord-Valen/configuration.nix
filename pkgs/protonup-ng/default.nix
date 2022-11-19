{
  lib,
  python3Packages,
  source,
  ...
}:
with python3Packages;
  buildPythonPackage rec {
    inherit (source) pname version src;

    propagatedBuildInputs = [requests configparser];

    doCheck = false;

    meta = with lib; {
      homepage = "https://github.com/cloudishBenne/protonup-ng";
      description = "Protonup fork for the new naming convention";
      licence = licenses.gpl3Only;
    };
  }
