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
    # ../../optional/persistance.nix
    # ../../optional/powerManagement.nix
    # ../../optional/v2ray.nix
    # ../../optional/virtualisation.nix
  ];

  networking = {
    hostName = "vm";
    # inherit hostName;
  };

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
      grub = {
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

  # fileSystems."/" =
  #   { device = "/dev/disk/by-label/nixos";
  #     fsType = "ext4";
  #   };

  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-label/boot";
  #     fsType = "vfat";
  #   };
  
  # swapDevices = [ ];

  # boot = {
  #   kernelParams = [
  #     "amdgpu.sg_display=0"
  #     "resume_offset=533760"
  #   ];
  #   blacklistedKernelModules = ["hid-sensor-hub"];
  #   supportedFilesystems = lib.mkForce ["btrfs"];
  #   kernelPackages = pkgs.linuxPackages_latest;
  #   loader = {
  #     systemd-boot.enable = true;
  #     efi.canTouchEfiVariables = true;
  #   };
  #   # resumeDevice = "/dev/disk/by-label/nixos";
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
