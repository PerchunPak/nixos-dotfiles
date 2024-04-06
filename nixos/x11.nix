{pkgs, ...}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us,cz,ua,ru";
    xkbVariant = ",qwerty,,";
    xkbOptions = "grp:alt_shift_toggle";
  };

  # Enable sound, these are settings from Gnome live ISO.
  # Enabling only pipewire results in crackling sound for me
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = false;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "perchun";
  };

  services.xserver.excludePackages = [pkgs.xterm];
}
