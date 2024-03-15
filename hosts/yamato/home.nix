_: {
  programs.kitty.settings.font_size = 22;

  programs.ssh = {
    matchBlocks = {
      "dev.work.local" = {
        hostname = "192.168.50.253";
        user = "hawtian";
        forwardAgent = true;
        forwardX11 = true;
        remoteForwards = [
          {
            bind.address = "LOCALHOST";
            bind.port = 2224;
            host.address = "localhost";
            host.port = 2224;
          }
          {
            bind.address = "LOCALHOST";
            bind.port = 2225;
            host.address = "localhost";
            host.port = 2225;
          }
        ];
        extraOptions = {
          KeepAlive = "yes";
        };
      };
      "dev.work.local.simple" = {
        hostname = "192.168.50.253";
        user = "hawtian";
        forwardAgent = true;
        extraOptions = {
          KeepAlive = "yes";
        };
      };
    };
  };
}
