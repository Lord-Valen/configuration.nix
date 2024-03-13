{ inputs, cell }:
{
  systemPackages = with inputs.nixpkgs; [
    binutils
    coreutils
    dnsutils
    inetutils
    iputils
    usbutils
    utillinux
    pciutils

    dosfstools
    btrfs-progs

    ripgrep
    fd
    file
    whois
    bottom
  ];
}
