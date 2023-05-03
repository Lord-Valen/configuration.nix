{
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  settings = {
    sandbox = true;

    trusted-users = ["root" "@wheel"];
    allowed-users = ["@wheel"];

    auto-optimise-store = true;
  };

  extraOptions = ''
    experimental-features = nix-command flakes
    min-free = 536870912
    keep-outputs = true
    keep-derivations = true
    fallback = true
  '';
}
