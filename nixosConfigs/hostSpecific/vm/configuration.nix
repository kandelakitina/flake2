# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  # hostName,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # inputs.hardware.nixosModules.lenovo-thinkpad-x1-7th-gen
    inputs.disko.nixosModules.disko
    
    ./hardware-configuration.nix

    ../../userSpecific/boticelli.nix

    (import ../../../diskoConfigs/btfrs.nix { device = "/dev/vda"; })

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

  networking = {
    hostName = "vm";
    # inherit hostName;
  };

  boot = {
    kernelParams = [
      "amdgpu.sg_display=0"
      "resume_offset=533760"
    ];
    blacklistedKernelModules = ["hid-sensor-hub"];
    supportedFilesystems = lib.mkForce ["btrfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # resumeDevice = "/dev/disk/by-label/nixos";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
