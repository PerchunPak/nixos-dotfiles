{ pkgs, ... }:
{
  services.xserver.enable = true;

  # Configure keymap
  services.xserver.xkb = {
    layout = "us,cz,ua,ru";
    variant = ",qwerty,,";
  };

  # Enable sound, these are settings from Gnome live ISO.
  # Enabling only pipewire results in crackling sound for me
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = true;
    user = "perchun";
  };

  programs.xwayland.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];
}
