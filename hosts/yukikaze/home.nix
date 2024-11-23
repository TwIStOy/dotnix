_: {
  programs.kitty.settings.font_size = 18;

  programs.ssh = {
    matchBlocks = {
      "poi.local" = {
        hostname = "192.168.50.226";
        user = "hawtian";
        forwardAgent = true;
        forwardX11 = true;
        extraOptions = {
          KeepAlive = "yes";
        };
      };
      "taihou.local" = {
        hostname = "192.168.50.252";
        user = "hawtian";
        forwardAgent = true;
        forwardX11 = true;
        extraOptions = {
          KeepAlive = "yes";
        };
      };
    };
  };
}
