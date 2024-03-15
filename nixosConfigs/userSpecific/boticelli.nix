{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # # Uncomment is using Home Manager as NixOS module
  # home-manager.users.boticelli = import ../../../homeConfigs/boticelli/${config.networking.hostName};

  sops.secrets.boticelli-password = {
    sopsFile = ./passwords.yaml;
    neededForUsers = true;
  };

  #users.mutableUsers = false;
  users.users.boticelli = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "networkmanager"
        "libvirtd"
        "kvm"
        "docker"
        "podman"
        "git"
        "network"
        "wireshark"
        "i2c"
        "tss"
        "plugdev"
      ];

    # initialPassword = "password";
    openssh.authorizedKeys.keys = [
      (builtins.readFile ../../homeConfigs/boticelli/id_ed25519.pub )
    ];

    hashedPasswordFile = config.sops.secrets.boticelli-password.path;
    packages = [pkgs.home-manager];
  };

  programs.fish.enable = true;
}
