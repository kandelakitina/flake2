# configuration.nix
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # inputs.hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix

    ../../userSpecific/boticelli.nix

    (import ../../../diskoConfigs/btfrs.nix {device = "/dev/vda";})

    ../../minimal/default.nix

    # ../../optional/auto-hibernate.nix
    # ../../optional/auto-upgrade.nix
    # ../../optional/bluetooth.nix
    # ../../optional/fingerprint.nix
    # ../../optional/gaming.nix
    ../../optional/gnome.nix
    # ../../optional/openGL.nix
    ../../optional/persistance.nix
    # ../../optional/powerManagement.nix
    # ../../optional/v2ray.nix
    # ../../optional/virtualisation.nix
  ];

  # customize kernel version
  # boot.kernelPackages = pkgs.linuxPackages_5_15;

  networking = {
    hostName = "vm";
    # inherit hostName;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      password = "admin";
      group = "admin";
    };
  };

  users.groups.admin = {};

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4048; # Use 2048MiB memory.
      cores = 4;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.firewall.allowedTCPPorts = [22];
  environment.systemPackages = with pkgs; [
    htop
    helix
  ];

  system.stateVersion = "23.05";
}
