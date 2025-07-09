{
  programs.jujutsu = {
    enable = true;
    ediff = false;
    settings = {
      inherit (config.programs.git) userName userEmail;
      signing = {
        behaviour = "drop";
        backend = "gpg";
      };
      git.sign-on-push = true;
    };
  };
}
