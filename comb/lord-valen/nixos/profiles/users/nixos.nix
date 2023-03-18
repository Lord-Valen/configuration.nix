{
  pkgs,
  ...
}: {
  users.users.nixos = {
    initialHashedPassword = "$y$j9T$QQ6ekOvwUjMHEpiW78DbX1$F7evMbAa0tQeMXFUiwBOViSAHqe2aij3BcxbARFgU6/";
    isNormalUser = true;
    createHome = true;
  };
}
