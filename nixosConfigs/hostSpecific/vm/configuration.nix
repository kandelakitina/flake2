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

    # inputs.disko.nixosModules.disko
    # (import ../../../diskoConfigs/btfrs.nix {device = "/dev/vda";})

    # ./hardware-configuration.nix

    ../../userSpecific/boticelli.nix

    # ../../minimal/default.nix

    # ../../optional/auto-hibernate.nix
    # ../../optional/auto-upgrade.nix
    # ../../optional/bluetooth.nix
    # ../../optional/fingerprint.nix
    # ../../optional/gaming.nix
    # ../../optional/gnome.nix
    # ../../optional/openGL.nix
    # ../../optional/persistance.nix
    # ../../optional/powerManagement.nix
    ../../optional/qemu.nix
    # ../../optional/v2ray.nix
    # ../../optional/virtualisation.nix
  ];

  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  networking = {
    # inherit hostName;
    hostName = "vm";
    firewall.enable = false;
  };

  # nixpkgs = {
  #   overlays =
  #     builtins.attrValues outputs.overlays
  #     ++ [
  #       # inputs.nixneovimplugins.overlays.default
  #       # inputs.neovim-nightly-overlay.overlay
  #     ];
  # };

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

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # # Dual boot
  # boot = {
  #   kernelPackages = pkgs.linuxPackages_latest;
  #   # initrd.kernelModules = ["nvidia_x11"];
  #   loader = {
  #     timeout = 5;
  #     efi = {
  #       canTouchEfiVariables = true;
  #       efiSysMountPoint = "/boot";
  #       # /boot will probably work too
  #     };
  #     grub = {
  #       enable = true;
  #       configurationLimit = 5;
  #       #device = ["nodev"];
  #       # Generate boot menu but not actually installed
  #       devices = ["nodev"];
  #       # Install grub
  #       efiSupport = true;
  #       useOSProber = true;
  #       # OSProber looks for installed systems
  #       # Or use extraEntries like seen with Legacy
  #       # OSProber will probably not find windows partition on first install.
  #       # Just do a rebuild than.
  #     };
  #   };
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
