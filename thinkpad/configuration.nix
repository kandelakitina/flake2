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
    inputs.hardware.nixosModules.lenovo-thinkpad-x1-7th-gen

    ./hardware-configuration.nix

    ../nixosConfigs
    ../nixosConfigs/users/boticelli.nix

    # ../nixosConfigs/extra/auto-hibernate.nix
    # ../nixosConfigs/extra/bluetooth.nix
    # ../nixosConfigs/extra/fingerprint.nix
    # ../nixosConfigs/extra/powerManagement.nix
    # ../nixosConfigs/extra/gaming.nix

    # ../nixosConfigs/extra/virtualisation.nix
    # ../nixosConfigs/extra/openGL.nix
    # ../nixosConfigs/extra/auto-upgrade.nix

  ];

  networking = {
    hostName = "thinkpad";
  };

  # modules.nixos = {
  #   avahi.enable = true;
  #   auto-hibernate.enable = false;
  #   backup.enable = true;
  #   bluetooth.enable = true;
  #   docker.enable = true;
  #   fingerprint.enable = true;
  #   gaming.enable = true;
  #   login.enable = true;
  #   extraSecurity.enable = true;
  #   power.enable = true;
  #   virtualisation.enable = true;
  #   vpn.enable = true;
  # };

  # Dual boot
  boot = { 
    kernelPackages = pkgs.linuxPackages_latest;
    # initrd.kernelModules = ["nvidia_x11"];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
        # /boot will probably work too
      };
      grub  = {
        enable = true;
        configurationLimit = 5;
        #device = ["nodev"];
        # Generate boot menu but not actually installed
        devices = ["nodev"];
        # Install grub
        efiSupport = true;
        useOSProber = true;
        # OSProber looks for installed systems
        # Or use extraEntries like seen with Legacy
        # OSProber will probably not find windows partition on first install. 
        # Just do a rebuild than.
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
