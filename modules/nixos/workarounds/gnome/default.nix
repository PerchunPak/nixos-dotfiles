{...}: {
  # Workaround for crashing session on auto-login
  # see https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
