_: {
  programs.kitty.settings.font_size = 18;

  programs.ssh = {
    matchBlocks = {
      "dev.work.local" = {
        hostname = "10.114.192.19";
        user = "wanghaot";
        forwardAgent = true;
        forwardX11 = true;
        extraOptions = {
          KeepAlive = "yes";
        };
      };
    };
  };
}
