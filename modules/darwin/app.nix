{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    gnugrep
    gnutar
    fish
  ];

  programs.zsh.enable = true;
  environment.shells = with pkgs; [
    zsh
    fish
    darwin.iproute2mac
  ];

  homebrew = {
    enable = false;

    onActivation = {
      autoUpdate = true;
      upgrade = true;

      cleanup = "zap";
    };

    masApps = {};

    taps = [
      "homebrew/services"
      "osx-cross/avr"
      "osx-cross/arm"
      "leoafarias/fvm"
      "qmk/qmk"
      "FelixKratz/formulae"
      "d12frosted/emacs-plus"
      "nikitabobko/tap"
    ];

    brews = [
      "wget"
      "curl"
      "aria2"
      "httpie"

      "gnu-sed"
      "gnu-tar"
      "jq"

      # "fvm" # for flutter

      # xcode related tools
      # "xcbeautify" # beautifier tool for xcodebuild
      # "xcode-build-server" # xcodeproject to lspconfigs
      "swift-format"
      "emacs-plus"
    ];

    casks = [
      "1password"
      "1password-cli"
      "iina"
      "arc"
      "google-chrome"
      "visual-studio-code"
      "karabiner-elements"
      "jetbrains-toolbox"
      "neovide"
      "wireshark"
      "kitty"
      "xquartz"
      "devpod"
      "follow"
      "raycast"
      "orbstack"
      "obsidian"
      "ghostty"
      "coteditor"
    ];
  };
}
