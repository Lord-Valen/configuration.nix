{
  inputs,
  cell,
  pkgs,
  lib,
}:
{
  hardware.gpgSmartcards.enable = true;
  # TODO: Remove after https://nixpk.gs/pr-tracker.html?pr=308884 hits unstable
  programs.gnupg.package = pkgs.gnupg.override {
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
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };
}
