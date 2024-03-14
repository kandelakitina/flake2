# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  hostName,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    #...
  ];

  # FIXME: Does not have effect
  # Environment
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.shellAliases = {
    hms = "home-manager switch --flake .#${config.home.username}@${hostName}";
  };

  nixpkgs = {
    overlays =
      builtins.attrValues outputs.overlays
      ++ [
        # inputs.nixneovimplugins.overlays.default
        # inputs.neovim-nightly-overlay.overlay
      ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";

  news = {
    display = "silent";
    json = lib.mkForce {};
    entries = lib.mkForce [];
  };
}
