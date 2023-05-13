{...}: {
  users.users.root = {
    initialHashedPassword = "$6$rZhNhLxPNJx.lRBn$lXAcMr7CdFgjRcN4ZMlEai2QYWMoawm6pMKrd9oFHXgWks9KBkP3p7Afj/Djj1LnCDyXbLNT5IfVNjDEUzk1p0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6sqfUwKC9nKlRbH9laeIBJjn9fDqIH57JsLFbMDAKh"
    ];
  };
  services.openssh.enable = true;
}
