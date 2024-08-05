{
  python3Packages,
  fetchFromGitHub,
  fetchPypi,
  lib,
}:
python3Packages.buildPythonApplication rec {
  pname = "kapowarr";
  version = "0-unstable-2024-07-10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Casvt";
    repo = "Kapowarr";
    rev = "b3bae88e2d0960f60a3ace79bdb5dcebc7f753c8";
    hash = "sha256-NbC1Itq7MnX9BEh7KIgZfPudS0FVmHK716rlAXu6G4M=";
  };

  build-system = with python3Packages; [ setuptools ];

  dependencies = with python3Packages; [
    (python3Packages.buildPythonPackage {
      pname = "bencoding";
      version = "0.2.6";

      src = fetchPypi {
        pname = "bencoding";
        version = "0.2.6";
        hash = "sha256-Q8zjHUhj4p1rxhFVHU6fJlK+KZXp1eFbRtg4PxgNREA=";
      };
    })
    requests
    beautifulsoup4
    flask
    flask-socketio
    waitress
    pycryptodome
    tenacity
    simplejson
    aiohttp
    regex
  ];

  preBuild = ''
    sed -i "s/bs4.*/beautifulsoup4 ~= 4.12.3/" requirements.txt

    cat > setup.py << EOF
    from setuptools import setup, find_packages, find_namespace_packages

    with open('requirements.txt') as f:
         install_requires = f.read().splitlines()

    setup(
      name='Kapowarr',
      version = '0.0.1',
      install_requires=install_requires,
      packages=[
        'frontend',
        'backend',
        'backend.lib',
        'backend.torrent_clients',
      ],
      scripts=[
        'Kapowarr.py'
      ],
    )
    EOF
  '';
  meta = {
    description = "Kapowarr is a software to build and manage a comic book library, fitting in the *arr suite of software";
    homepage = "https://casvt.github.io/Kapowarr";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ lord-valen ];
    mainProgram = "Kapowarr.py";
    platforms = lib.platforms.all;
    # FIXME: something is throwing an exception in main which causes the cli to
    # error out with a message about the DatabaseFolder flag. It's really a
    # problem elsewhere, this message is sent because of a try/catch.
    broken = true;
  };
}
