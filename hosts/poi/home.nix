_: {
  programs.ssh = {
    extraConfig = ''
      Host github.com
          HostName %h
          ProxyCommand nc -X 5 -x 192.168.50.217:8889 %h %p
    '';
  };
}
