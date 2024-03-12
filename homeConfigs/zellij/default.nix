{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config) colorScheme;
in {
  imports = [
    ./sesh.nix
  ];

  home.packages = [
    # pkgs.tmate
    inputs.zjstatus.packages.${pkgs.system}.default
  ];

  # xdg.configFile = {
  #   "zellij/config.kdl".source = ./config.kdl;
  #   "zellij/layouts/mine.kdl".text = ''
  #     layout {
  #      tab {
  #     	 pane
  #      }

  #      default_tab_template {
  #     	 pane size=1 borderless=true {
  #     		 plugin location="zellij:compact-bar"
  #     	 }
  #     	 children
  #      }
  #     }
  #   '';
  # };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      theme = "nix-${colorScheme.slug}";
      themes = import ./themes.nix {inherit colorScheme;};
      defaultShell = "fish";
      copyOnSelect = true;

      # keybinds = {
      #   unbind = ["Ctrl q"];
      #   normal = {};
      #   locked = {
      #     clearDefaults = true;
      #     bind = [
      #       {
      #         key = "Alt u";
      #         action = "SwitchToMode 'normal'";
      #       }
      #     ];
      #   };
      #   resize = {
      #     clearDefaults = true;
      #     bind = [
      #       {
      #         key = "Esc";
      #         action = {SwitchToMode = "Normal";};
      #       }
      #       # Additional bindings...
      #     ];
      #   };
      #   # Additional modes and bindings...
      # };
    };
  };
}
