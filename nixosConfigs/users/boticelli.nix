{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # TODO: Import your home-manager configuration
      boticelli = import ../../${config.networking.hostName}/home.nix;
    };
  };
  
  # sops.secrets.haseeb-password = {
  #   sopsFile = ./secrets.yaml;
  #   neededForUsers = true;
  # };

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

    initialPassword = "password";
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDeOnbApjXX4zpivLrgu9jqMpkcF0WQvaVPqw8b+CK9U/L8Ds+ZXhAPssiufJGkl6DZRARlF4SMgnXLVCyiJpFO7XiGsrvBI1eQvFcgO2CxNDTah+Nyi8BBfCU7lXZxRMLONlsKk5/msaxgKHL7cr5Rxbk0Xi++4Yl80dlUoKhLEl78iU2RsUJ+Qn127W9/d/ug2vbWbYUFd6zI/ggiqHkt1VR2Kat43OMNWrrYkKnkiT0Tw2kt0y3c3yKW2/IOpz7+77UztmlArBXNGCUQuyKWLy3EzUUsVrH3p3v6hD2N3nqv5IJbg0QsIcYH/Yde9rzloUmX6hx3CBnLPhxpCNIkn9qVJtlIGMDkdgAOyBawJLeraRWZyA+LvWbqtb/5a6cXVf3rBBHSKf9YXv+AoK8WYZ1CyGrGCc1tG/lio5KofC/f4DESyqPhKT/clr4itaUwIsOhZYtQ3SbEh06d0JggWRP0lCH2gQqEOHa3jpA2PmOQ1scEVpO1Vq2+PM7flpbGK2CzuyjmimsIvVP+hrUzOnqVv6MOiS0so+JcWipXLwieL9VutM5pdmoyJgqS0IWmztPvgKG88xrZZZwBtHbPUzZbY0jlmkiOQhg7TTU221gC2IpDSufnoYOfJvma1T5Rni6j51gQsK84sfdRSTvlWjd86kpQhFA2K8Kqj0ofzw== kandelakitina@gmail.com"
    ];

    #hashedPasswordFile = config.sops.secrets.haseeb-password.path;
    packages = [pkgs.home-manager];
  };

  programs.fish.enable = true;
}
