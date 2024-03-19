{ pkgs, inputs, ... }:

{ 
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.persistence."/persist/home/${config.username}" = {
    directories = [
      ".gnupg"
      ".local/share/direnv"
      ".local/share/keyrings"
      ".nixops"
      ".ssh"
      "Documents"
      "Downloads"
      "flake2"
      "Music"
      "Pictures"
      "Videos"
      "VirtualBox VMs"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      # ".screenrc"
    ];
    allowOther = true;
  };
}
