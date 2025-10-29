{
  inputs,
  cell,
  pkgs,
}:
{
  systemPackages = with pkgs; [
    binutils
    coreutils
    dnsutils
    inetutils
    iputils
    usbutils
    utillinux
    pciutils

    gptfdisk
    dosfstools
    btrfs-progs

    ripgrep
    fd
    file
    whois
    bottom
  ];
}
