{
  # these are settings from Gnome live ISO.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # https://youtu.be/Kt0dkXWnaC4
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';
}
