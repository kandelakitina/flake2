{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    # Import home-manager's NixOS module
    # inputs.home-manager.nixosModules.home-manager

    # simple flake to solve 'command-not-found' issue
    inputs.flake-programs-sqlite.nixosModules.programs-sqlite

  ]
  ++ (builtins.attrValues outputs.nixosModules); 

  # programs.hyprland.enable = true;

  # home-manager.extraSpecialArgs = {
  #   inherit inputs outputs;
  # };
  networking.networkmanager.enable = true;

  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
  };

  environment.systemPackages = with pkgs; [
    helix
    git
    curl
    wget
  ];

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services = {
    openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # Use keys only. Remove if you want to SSH using password (not recommended)
        PasswordAuthentication = false;
      };
    };

    # # TODO: find out what are these?
    # pcscd.enable = true;
    # udev.packages = with pkgs; [yubikey-personalization];
    # gvfs.enable = true;
    # udisks2.enable = true;
    # fwupd.enable = true;
    # dbus.packages = [pkgs.gcr];
  };

  # Sound options
  sound.enable = true;
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Locale
  i18n = {
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  time.timeZone = "Europe/Moscow";

  services.xserver = {
    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle,caps:escape";
  };

  console.keyMap = "us"; 

  # Some default backend
  # ********************
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = lib.mkDefault true;
      use-xdg-base-directories = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
      system-features = ["kvm" "big-parallel" "nixos-test"];
 
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

    gc = {
      automatic = true;
      dates = "weekly";
      # Delete older generations too
      options = "--delete-older-than 2d";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };
}
