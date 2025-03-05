{
  system.defaults = {
    finder = {
      _FXShowPosixPathInTitle = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXRemoveOldTrashItems = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    WindowManager = {
      AutoHide = true;
      EnableStandardClickToShowDesktop = false;
    };

    controlcenter = {
      Bluetooth = true;
      BatteryShowPercentage = true;
      Sound = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;

      KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
      InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;
    };

    dock = {
      autohide = true;
      show-recents = false;
      launchanim = true;
      orientation = "left";
      tilesize = 30;
    };

    menuExtraClock.ShowSeconds = true;

    # Get rid of stupid emoji button
    hitoolbox.AppleFnUsageType = "Do Nothing";

    # Make animations faster
    dock.expose-animation-duration = 3.0;
  };
}
