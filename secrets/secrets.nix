let
  perchun = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBAYRpKyd+XVaQB766vBWxZHEB34RoLpFFWJKcxo4Ze";
in
{
  "gpg-key.age".publicKeys = [ perchun ];
  "ssh-config.age".publicKeys = [ perchun ];
}
