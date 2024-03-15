{lib, ...}: {
  networking.firewall.enable = lib.mkDefault false;

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      ClientAliveInterval = 60;
      ClientAliveCountMax = 30;
    };
  };
}
