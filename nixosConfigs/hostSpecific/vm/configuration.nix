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
    (import ../../../diskoConfigs/btfrs.nix {device = "/dev/vda";})

    ./hardware-configuration.nix

    ../../userSpecific/boticelli.nix


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

  # fileSystems."/" = {
  #   device = "/dev/root_vg/root";
  #   fsType = "btrfs";
  #   options = [ "subvol=root" ];
  # };

  boot.loader.systemd-boot.enable = true; # (for UEFI systems only)

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  # fileSystems."/persistent" = {
  #   device = "/dev/root_vg/root";
  #   neededForBoot = true;
  #   fsType = "btrfs";
  #   options = [ "subvol=persistent" ];
  # };

  # fileSystems."/nix" = {
  #   device = "/dev/root_vg/root";
  #   fsType = "btrfs";
  #   options = [ "subvol=nix" ];
  # };

  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-label/boot";
  #   fsType = "vfat";
  # };

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
