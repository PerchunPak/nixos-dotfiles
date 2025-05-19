let
  perchun = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBAYRpKyd+XVaQB766vBWxZHEB34RoLpFFWJKcxo4Ze";
in
{
  "aws-dev.age".publicKeys = [ perchun ];
  "aws-perchun.age".publicKeys = [ perchun ];
  "aws-work-cmd.age".publicKeys = [ perchun ];
  "gpg-key.age".publicKeys = [ perchun ];
  "ssh-config.age".publicKeys = [ perchun ];
}
