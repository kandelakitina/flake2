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

}
