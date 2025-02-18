{
  programs.gpg = {
    enable = true;
    scdaemonSettings.disable-ccid = true;
    publicKeys = [
      {
        source = ./_4E40028CD3E1B80A7D58A19DC5129E27E5CCA729;
        trust = 5;
      }
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [
      "354FAC6D58C11AF32494"
      "38AA565BD540BD2CA31F"
    ];
  };
}
