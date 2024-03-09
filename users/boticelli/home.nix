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
    # ../../homeConfigs/atuin

    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  # FIXME: Does not have effect
  # Environment
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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
