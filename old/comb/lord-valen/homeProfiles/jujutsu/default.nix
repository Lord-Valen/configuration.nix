{
  programs.jujutsu = {
    enable = true;
    ediff = false;
    settings = {
      user =
        let
          inherit (config.programs.git) userName userEmail;
        in
        {
          name = userName;
          email = userEmail;
        };
      signing = {
        behaviour = "drop";
        backend = "gpg";
      };
      git.sign-on-push = true;
    };
  };
}
