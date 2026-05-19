{
  den.aspects.lord-valen.homeManager = {
    systemd.user.tmpfiles.rules = [
      "e %h/Downloads - - - 2w"
      "e %h/sandbox   - - - 2w"
    ];
  };
}
