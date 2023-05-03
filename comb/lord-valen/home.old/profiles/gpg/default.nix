{
  programs.gpg = {
    enable = true;
    scdaemonSettings.disable-ccid = true;
    publicKeys = [
      {
        source = ./4E40028CD3E1B80A7D58A19DC5129E27E5CCA729;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = ["BB26077842824E5F7FA4693635CCA30C3972D21A"];
  };
}
