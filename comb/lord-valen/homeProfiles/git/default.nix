{
  programs.git = {
    enable = true;

    userName = "Lord-Valen";
    userEmail = "lord_valen@protonmail.com";

    extraConfig = {
      github.user = "Lord-Valen";
      gitlab.user = "Lord-Valen";
      init.defaultBranch = "main";
      merge.confictStyle = "zdiff3";

      fetch = {
        prune = true;
        pruneTags = true;
      };

      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        default = "current";
      };

      remote.pushDefault = "Lord-Valen";
    };

    signing = {
      key = "C5129E27E5CCA729";
      signByDefault = true;
    };

    aliases = {
      a = "add -p";
      co = "checkout";
      cob = "checkout -b";
      f = "fetch -p";
      c = "commit";
      p = "push";
      ba = "branch -a";
      bd = "branch -d";
      bD = "branch -D";
      d = "diff";
      dc = "diff --cached";
      ds = "diff --staged";
      r = "restore";
      rs = "restore --staged";
      st = "status -sb";

      # reset
      soft = "reset --soft";
      hard = "reset --hard";
      s1ft = "soft HEAD~1";
      h1rd = "hard HEAD~1";

      # logging
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      plog = "log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'";
      tlog = "log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative";
      rank = "shortlog -sn --no-merges";

      # delete merged branches
      bdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d";
    };
  };
}
