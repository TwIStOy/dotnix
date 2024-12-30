_: {
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
