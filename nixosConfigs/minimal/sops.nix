{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    gnupg = {
      home = "~/.gnupg";
      sshKeyPaths = [];
    };
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519"];
  };
}

# { inputs, lib, config, ... }:
# let
#   isEd25519 = k: k.type == "ed25519";
#   getKeyPath = k: k.path;
#   keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
# in
# {
#   imports = [
#     inputs.sops-nix.nixosModules.sops
#   ];

#   sops = {
#     age.sshKeyPaths = map getKeyPath keys;
#   };
# }
