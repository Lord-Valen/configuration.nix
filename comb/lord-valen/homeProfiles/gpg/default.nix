{
  inputs,
  cell,
  pkgs,
  lib,
}:
{
  programs.gpg = {
    # TODO: Remove after https://nixpk.gs/pr-tracker.html?pr=308884 hits unstable
    package = pkgs.gnupg.override {
      pcsclite = pkgs.pcsclite.overrideAttrs (old: {
        postPatch =
          old.postPatch
          + (lib.optionalString
            (!(lib.strings.hasInfix ''--replace-fail "libpcsclite_real.so.1"'' old.postPatch))
            ''
              substituteInPlace src/libredirect.c src/spy/libpcscspy.c \
                --replace-fail "libpcsclite_real.so.1" "$lib/lib/libpcsclite_real.so.1"
            ''
          );
      });
    };
    enable = true;
    scdaemonSettings.disable-ccid = true;
    publicKeys = [
      {
        source = ./_4E40028CD3E1B80A7D58A19DC5129E27E5CCA729;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [
      "354FAC6D58C11AF32494"
      "38AA565BD540BD2CA31F"
    ];
  };
}
