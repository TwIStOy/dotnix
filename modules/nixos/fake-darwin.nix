{lib, ...}: {
  options.homebrew = {
    taps = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = [];
      description = "Homebrew taps to add";
    };

    brews = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = [];
      description = "Homebrew packages to install";
    };

    casks = lib.mkOption {
      type = lib.types.listOf lib.types.string;
      default = [];
      description = "Homebrew casks to install";
    };
  };

  options.launchd = {
  };
}
