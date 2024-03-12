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
    ./options.nix

    ../global

    ../extra/alacritty
    ../extra/fish
    ../extra/nnn
    ../extra/zellij
    ../extra/fonts
    ../extra/git
    ../extra/starship
    ../extra/helix
    ../extra/cliTools
    ../extra/cheatSheets
    ../extra/direnv
    ../extra/firefox

    # ../extra/gaming
    # ../extra/atuin

    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  colorScheme = import ../colorschemes/iterm.nix;
  # colorScheme = import ./colorschemes/dracula_at_night.nix;
  # colorscheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;

  nixpkgs = {
    overlays =
      builtins.attrValues outputs.overlays
      ++ [
        # inputs.nixneovimplugins.overlays.default
        # inputs.neovim-nightly-overlay.overlay
        inputs.nixgl.overlay
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
}
