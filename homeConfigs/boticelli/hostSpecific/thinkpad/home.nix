# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [

    # Defines options, like fonts, for specific machine
    ./options.nix

    ../../minimal

    ../../optional/alacritty
    # ../../optional/atuin
    ../../optional/bitwarden
    ../../optional/cheatSheets
    ../../optional/cliTools
    # ../../optional/direnv
    ../../optional/firefox
    ../../optional/fish
    ../../optional/fonts
    # ../../optional/gaming
    ../../optional/git
    ../../optional/gpg
    ../../optional/helix
    ../../optional/nnn
    ../../optional/persistence
    ../../optional/sops
    ../../optional/starship
    ../../optional/zellij

    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  colorScheme = import ../../colorschemes/iterm.nix;
  # colorScheme = import ./colorschemes/dracula_at_night.nix;
  # colorscheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;

  nixpkgs = {
    overlays =
      builtins.attrValues outputs.overlays
      ++ [
        # inputs.nixneovimplugins.overlays.default
        # inputs.neovim-nightly-overlay.overlay
        # inputs.nixgl.overlay
      ];
  };

  # TODO: Set your username
  home = rec {
    username = "boticelli";
    homeDirectory = "/home/${username}";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # home.packages = with pkgs; [nixgl.nixGLIntel];
}
