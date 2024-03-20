{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [

    # simple flake to solve 'command-not-found' issue
    inputs.flake-programs-sqlite.nixosModules.programs-sqlite

    # Uncomment if using Home Manager as NixOS module
    inputs.home-manager.nixosModules.home-manager

    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./pam.nix
    ./sound.nix
    ./sops.nix

  ]
  ++ (builtins.attrValues outputs.nixosModules); 

  # programs.hyprland.enable = true;

  # Uncomment if using Home Manager as NixOS module
  home-manager.extraSpecialArgs = {  
    inherit inputs outputs;
  };

  networking.networkmanager.enable = true;

  environment.shellAliases = {
    # nrs = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
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
    
    # # TODO: find out what are these?
    # pcscd.enable = true;
    # udev.packages = with pkgs; [yubikey-personalization];
    # gvfs.enable = true;
    # udisks2.enable = true;
    # fwupd.enable = true;
    # dbus.packages = [pkgs.gcr];
  };
}
