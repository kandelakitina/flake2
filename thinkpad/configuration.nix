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
    # inputs.hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix

    ../nixosConfigs
    ../nixosConfigs/users/boticelli.nix
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
  
  # # Install Home-Manager module with users
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs outputs; };
  #   users = {
  #     # TODO: Import your home-manager configuration
  #     boticelli = import ./home.nix;
  #   };
  # };

  # environment.variables = {
  #   EDITOR = "hx";
  #   VISUAL = "hx";
  # };

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

    # adding cachix servers for quick binary download
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # FIXME: Add the rest of your current configuration

  # TODO: Make your own boot settings
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

  # # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  # users.users = {
  #   # FIXME: Replace with your username
  #   boticelli = {
  #     # TODO: You can set an initial password for your user.
  #     # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
  #     # Be sure to change it (using passwd) after rebooting!
  #     initialPassword = "password";
  #     isNormalUser = true;
  #     openssh.authorizedKeys.keys = [
  #       # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
  #       "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDeOnbApjXX4zpivLrgu9jqMpkcF0WQvaVPqw8b+CK9U/L8Ds+ZXhAPssiufJGkl6DZRARlF4SMgnXLVCyiJpFO7XiGsrvBI1eQvFcgO2CxNDTah+Nyi8BBfCU7lXZxRMLONlsKk5/msaxgKHL7cr5Rxbk0Xi++4Yl80dlUoKhLEl78iU2RsUJ+Qn127W9/d/ug2vbWbYUFd6zI/ggiqHkt1VR2Kat43OMNWrrYkKnkiT0Tw2kt0y3c3yKW2/IOpz7+77UztmlArBXNGCUQuyKWLy3EzUUsVrH3p3v6hD2N3nqv5IJbg0QsIcYH/Yde9rzloUmX6hx3CBnLPhxpCNIkn9qVJtlIGMDkdgAOyBawJLeraRWZyA+LvWbqtb/5a6cXVf3rBBHSKf9YXv+AoK8WYZ1CyGrGCc1tG/lio5KofC/f4DESyqPhKT/clr4itaUwIsOhZYtQ3SbEh06d0JggWRP0lCH2gQqEOHa3jpA2PmOQ1scEVpO1Vq2+PM7flpbGK2CzuyjmimsIvVP+hrUzOnqVv6MOiS0so+JcWipXLwieL9VutM5pdmoyJgqS0IWmztPvgKG88xrZZZwBtHbPUzZbY0jlmkiOQhg7TTU221gC2IpDSufnoYOfJvma1T5Rni6j51gQsK84sfdRSTvlWjd86kpQhFA2K8Kqj0ofzw== kandelakitina@gmail.com"
  #     ];
  #     # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
  #     extraGroups = ["wheel"];

  #     # default shell
  #     shell = pkgs.fish;
  #   };
  # };

  # programs.fish.enable = true;

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
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
  system.stateVersion = "23.11";
}
