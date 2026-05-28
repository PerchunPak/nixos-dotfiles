# https://youtu.be/Kt0dkXWnaC4
{
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';
}
