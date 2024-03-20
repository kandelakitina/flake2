{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  fileSystems."/persist".neededForBoot = true;

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"

      # "/home/boticelli"

      # { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    # files = [
    #   "/etc/machine-id"
    #   { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    # ];

    # users.boticelli = {
    #   directories = [
    #     "Downloads"
    #     "flake2"
    #     "VMs"
    #     { directory = ".gnupg"; mode = "0700"; }
    #     { directory = ".ssh"; mode = "0700"; }
    #     { directory = ".nixops"; mode = "0700"; }
    #     { directory = ".local/share/keyrings"; mode = "0700"; }
    #     ".local/share/direnv"
    #   ];
    #   files = [
    #     # ".screenrc"
    #   ];
    # };
  };

  # environment.persistence = {
  #   "/persist" = {
  #     hideMounts = true;
  #     directories = [
  #       "/srv"
  #       "/etc/ssh"
  #       "/var/lib/systemd"
  #       "/var/lib/nixos"
  #       "/var/db/sudo/lectured"
  #       "/var/log"
  #       "/var/lib/bluetooth"
  #       # "/var/lib/systemd/coredump"
  #       "/etc/NetworkManager/system-connections"

  #       "/home/${config.username}/flake2"
  #       "/home/${config.username}/.ssh"
  #     ];
  #     files = [
  #       "/etc/machine-id"
  #       # "/etc/nix/id_rsa"
  #     ];
  #   };
  # };

  programs.fuse.userAllowOther = true;

  # system.activationScripts.persistent-dirs.text = let
  #   mkHomePersist = user:
  #     lib.optionalString user.createHome ''
  #       mkdir -p /persist/${user.home}
  #       chown ${user.name}:${user.group} /persist/${user.home}
  #       chmod ${user.homeMode} /persist/${user.home}
  #     '';
  #   users = lib.attrValues config.users.users;
  # in
  #   lib.concatLines (map mkHomePersist users);

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
