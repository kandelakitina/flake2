{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {

      env = {
        TERM = "xterm-256color";
      };

      # window = {
      #   padding = {
      #     x = 30;
      #     y = 30;
      #   };
      #   decorations = "none";
      # };

      mouse_bindings = [
        {
          mouse = "Right";
          action = "Paste";
        }
      ];

      font = {
        normal = {
          family = config.my.settings.fonts.monospace;
        };
        size = config.my.settings.fonts.size;
      };

      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;

      shell = {
        program = "fish";
      };

      theme = "iTerm-Default";
      colors = {
        bright = {
          black = "#565656";
          blue = "#49a4f8";
          cyan = "#99faf2";
          green = "#c0e17d";
          magenta = "#a47de9";
          red = "#ec5357";
          white = "#ffffff";
          yellow = "#f9da6a";
        };
        normal = {
          black = "#2e2e2e";
          blue = "#47a0f3";
          cyan = "#64dbed";
          green = "#abe047";
          magenta = "#7b5cb0";
          red = "#eb4129";
          white = "#e5e9f0";
          yellow = "#f6c744";
        };
        primary = {
          background = "#101421";
          foreground = "#fffbf6";
        };
      };
    };
  };
}
