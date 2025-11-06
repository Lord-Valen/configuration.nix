{
  flake.modules.homeManager.lord-valen = {
    systemd.user.tmpfiles.rules = [
      "e %h/Downloads - - - 2w"
      "e %h/sandbox   - - - 2w"
    ];
  };
}
