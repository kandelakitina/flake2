{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ...
  ];

  services = {

    # TODO: move to a separate host for VM
    spice-vdagentd.enable = true; # Clipboard share in VM

    # Gnome settings
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        defaultSession = "gnome";
      };
      desktopManager = {
        gnome.enable = true;
      };
    };
  };
}

