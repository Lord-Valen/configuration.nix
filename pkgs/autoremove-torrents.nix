{
  deluge,
  fetchFromGitHub,
  lib,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "autoremove-torrents";
  version = "1.5.5";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jerrymakesjelly";
    repo = "autoremove-torrents";
    rev = version;
    hash = "sha256-XKH7LtJusQIgPxRETeqw+2guFXQhaJaRzgcVujRXk00=";
  };

  build-system = with python3Packages; [
    setuptools
  ];

  # pythonImportsCheck = [
  #   "autoremove_torrents"
  # ];

  dependencies = with python3Packages; [
    deluge-client
    ply
    pyyaml
    requests
  ];

  prePatch = ''
    substituteInPlace setup.py \
      --replace-warn enum34 ""
  '';

  meta = {
    description = "Automatically remove torrents according to your strategies";
    homepage = "https://github.com/jerrymakesjelly/autoremove-torrents";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "autoremove-torrents";
  };
}
