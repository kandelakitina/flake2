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
    inputs.home-manager.nixosModules.home-manager

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Proxy
    ./v2ray

    # GNOME
    ./gnome
  ]
  ++ (builtins.attrValues outputs.nixosModules); 

  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  networking.networkmanager.enable = true;
  # programs.hyprland.enable = true;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
