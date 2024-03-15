_: {
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        "features" = {"containerd-snapshotter" = true;};
      };
      enableOnBoot = true;
    };
  };
}
