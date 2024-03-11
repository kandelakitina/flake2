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
    
    ../../homeConfigs/default.nix

    ../../homeConfigs/alacritty
    ../../homeConfigs/fish
    ../../homeConfigs/nnn
    ../../homeConfigs/zellij
    ../../homeConfigs/fonts
    ../../homeConfigs/git
    ../../homeConfigs/starship
    ../../homeConfigs/helix
    ../../homeConfigs/cliTools
    ../../homeConfigs/cheatSheets
    ../../homeConfigs/direnv
    ../../homeConfigs/firefox

    # ../../homeConfigs/gaming
    # ../../homeConfigs/atuin

    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  colorScheme = import ./iterm.nix;
  # colorScheme = import ./dracula_at_night.nix;
  # colorscheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;

  # FIXME: Does not have effect
  # Environment
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  nixpkgs = {
    overlays =
      builtins.attrValues outputs.overlays
      ++ [
        # inputs.nixneovimplugins.overlays.default
        # inputs.neovim-nightly-overlay.overlay
      ];
  };

  # TODO: Set your username
  home = {
    username = "boticelli";
    homeDirectory = "/home/boticelli";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
}
