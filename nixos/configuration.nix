# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    ./home-manager.nix
    ./x11.nix
    ./gnome.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Let sudo to remember my password for longer time
  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=30
  '';

  users.users = {
    perchun = {
      isNormalUser = true;
      description = "Perchun Pak";
      hashedPassword = "$y$j9T$K1EYVhXG6o2yQPH4IUDsw0$P8nQZaE554VdULdAdPmJ2Z9S/fwQ132V6oYiM.RGZWB";
      # TODO remove after migrating from VM
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0DC/ybIBaOD4wi2paqfhkbXRbMTe1fqHOTHSSEuYqAYaQfEjIjEG3ZPE6qKO7Gy/QasMYn5GD9sO0JvQXlmaj7oLVskRww2Y6/c+zKQt+o7T1nLMz1UJjlsS1j97dmEYQYKZ/Ku8Tf2e/9VUSAxuRN92EZrEk8gSckO18rnCbYTUJeZS8nx0035y+1PUTq3PvVJvm3uPMhdCW3eoZPm/NOyxQlbxwNujC6DUyz5ovjsWCC9S8rKNz+n1RiFS4TEv/JgZwEgdQbAttzDStoeFDPOVdyxjFsf2GsNYfS9cqO14YfJe/43ntQxmJ5c2Tmx+z+QsRWlyy874J4sYGBL6cidXFHK3wC43au2avMmbaa1NBnYl1Pf+97z2m+oqwTDopO0B6wehj3Bg03xqzosaJ+yeJ0sKudRj1HYvr8qpwp9zJBZf1xPyeHjR0oXJt/7X0OUVHFXpdjI06s0lKb+Zt9VtmucaMma4RbmIWmPKoCnM0xlxNWmU2FS3bEmTggSc="
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpFV18keTYwn5JsLUraDgYIQq66+uc1XgpN6MjRfLCZPN0MsZbaXxqnoNPJgo4uKT1QozIQ0M/w5DLsWtenbNIdLMnWg9NIf0uTnnK7vmFA5bLO0qNeUFqhwgC1i9zOKzSkUvjabFv/Kou0yQqeU10VDwRJ7uIAPgvsN0wbfLIL1W5wSZAIqny8KXg4U4qjAsZsnDKKCO2X9jTTmpkudCGjs5MQu1T+0xGCFHVyA+nCBMUaTYUst9xREEA8dQQ2Sp0frZU1ALSXkSsS2UOtkoAsjxL4GLGBrpl4xEUlpkGv3uuVf3USBkgacyfoOXljiFzQJCv78fybPWT+3OThyHwpmrOD1WuTiP0O4Vq+CNFumxpOqecIugzObtUBaqOXUYzxnjmBe9r1YS6JiJr+mnVtjdO3dV7OI1H6ohTUFOuS1HPBNv/C9E0tGby8X/7M8f13YWqMnSXBKy2SWDhg3LilFaKTiVxqasooBnHVuXRfDFmjctoTDSfiMQiAkEHGQs="
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINAVyEb+BB9gVfZBidXAIs5MZnqxFVDhC7rRdmMu3ytz"
      ];
      extraGroups = ["wheel" "networkmanager" "docker"];
    };
  };

  # TODO remove after migrating from VM
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
