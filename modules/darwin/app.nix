{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    gnugrep
    gnutar
    fish
  ];

  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
    pkgs.fish
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;

      cleanup = "zap";
    };

    masApps = {};

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
      "osx-cross/avr"
      "osx-cross/arm"
      "leoafarias/fvm"
      "qmk/qmk"
      "FelixKratz/formulae"
      "d12frosted/emacs-plus"
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
    ];

    casks = [
      "1password"
      "1password-cli"
      "iina"
      "arc"
      "google-chrome"
      "visual-studio-code"
      "telegram"
      "discord"
      "karabiner-elements"
      "jetbrains-toolbox"
      "tailscale"
      "neovide"
      "wireshark"
      "kitty"
      "xquartz"
      "devpod"
      "follow"
    ];
  };
}
