{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./starship];

  programs.bash.enable = true;
  home.shellAliases = {
    # quick cd
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    # git
    g = "git";

    # grep
    grep = "rg";
    gi = "grep -i";

    # internet ip
    myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

    # nix
    n = "nix";
    nepl = "n repl '<nixpkgs>'";
    nr = "n run";
    nd = "n develop";
    ns = "n shell";
    np = "n profile";
    npl = "np list";
    npi = "np install";
    npr = "np remove";
    npu = "np upgrade";
    npua = "npu '.*'";
    nf = "n flake";
    nfu = "nf update";
    nfck = "nf check";

    # bottom
    top = "btm";

    # sudo
    s = "sudo -E ";
    si = "sudo -i";
    se = "sudoedit";

    # systemd
    ctl = "systemctl";
    stl = "s systemctl";
    utl = "systemctl --user";
    ut = "systemctl --user start";
    un = "systemctl --user stop";
    up = "s systemctl start";
    dn = "s systemctl stop";
    jtl = "journalctl";
  };
}
