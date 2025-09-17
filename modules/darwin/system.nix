_: {
  security.pam.services.sudo_local.touchIdAuth = true;

  # fix timezone
  time.timeZone = "Asia/Shanghai";

  system = {
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
        mru-spaces = false;

        largesize = 128;
        tilesize = 30;

        # disable all hot curners
        wvous-tl-corner = 1; # top-left - Mission Control
        wvous-tr-corner = 1; # top-right - Desktop
        wvous-bl-corner = 1; # bottom-left - Application Windows
        wvous-br-corner = 1; # bottom-right - Lock Screen
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path on title bar
        AppleShowAllExtensions = true; # show all file extensions
        # disable warning when changing file extension
        FXEnableExtensionChangeWarning = false;
        ShowStatusBar = true;
        ShowPathbar = true;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true; # natural scrolling

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 3; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        ApplePressAndHoldEnabled = false; # enable press and hold

        # disable auto capitalization(自动大写)
        NSAutomaticCapitalizationEnabled = false;
        # disable auto dash substitution(智能破折号替换)
        NSAutomaticDashSubstitutionEnabled = false;
        # disable auto period substitution(智能句号替换)
        NSAutomaticPeriodSubstitutionEnabled = false;
        # disable auto quote substitution(智能引号替换)
        NSAutomaticQuoteSubstitutionEnabled = false;
        # disable auto spelling correction(自动拼写检查)
        NSAutomaticSpellingCorrectionEnabled = false;
        # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        # Move windows by holding 'ctrl' + 'cmd' and dragging any part of the window
        NSWindowShouldDragOnGesture = true;
      };

      CustomUserPreferences = {
        "com.microsoft.VSCode" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.microsoft.VSCodeInsiders" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.vscodium" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.microsoft.VSCodeExploration" = {
          ApplePressAndHoldEnabled = false;
        };
      };
    };
  };
}
