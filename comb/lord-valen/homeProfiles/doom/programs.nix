{
  inputs,
  cell,
}: {
  _imports = [inputs.nix-doom-emacs.hmModule];
  doom-emacs = {
    enable = true;
    doomPrivateDir = ./_doom.d;
    emacsPackagesOverlay = self: super: {
      nushell-mode = self.trivialBuild {
        pname = "nushell-mode";
        ename = "nushell-mode";
        version = "0.1.0";
        buildInputs = [];
        src = inputs.nixpkgs.fetchFromGitHub {
          owner = "azzamsa";
          repo = "emacs-nushell";
          rev = "5ffe4382fef4bad87ebc1fd5fb9787d40d6ea128";
          sha256 = "07mfr8skx9xncmdxf95fhxrwdys170606pb411layd8wzn0pfm7i";
        };
      };
    };
  };
}
