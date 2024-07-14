{
  programs = {
    rofi.extraConfig = {
      modes = "drun,ssh";
      # https://github.com/davatorium/rofi/issues/2005
      # show-icons = true;
      ssh-client = "kitten ssh";
    };
  };
}
