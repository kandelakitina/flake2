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

      # theme = "iTerm-Default";
      # colors = {
      #   bright = {
      #     black = "#565656";
      #     blue = "#49a4f8";
      #     cyan = "#99faf2";
      #     green = "#c0e17d";
      #     magenta = "#a47de9";
      #     red = "#ec5357";
      #     white = "#ffffff";
      #     yellow = "#f9da6a";
      #   };
      #   normal = {
      #     black = "#2e2e2e";
      #     blue = "#47a0f3";
      #     cyan = "#64dbed";
      #     green = "#abe047";
      #     magenta = "#7b5cb0";
      #     red = "#eb4129";
      #     white = "#e5e9f0";
      #     yellow = "#f6c744";
      #   };
      #   primary = {
      #     background = "#101421";
      #     foreground = "#fffbf6";
      #   };
      # };
      colors = {
        primary = {
          background = "#${config.colorscheme.palette.base00}";
          foreground = "#${config.colorscheme.palette.base05}";
          dim_foreground = "#${config.colorscheme.palette.base05}";
          bright_foreground = "#${config.colorscheme.palette.base05}";
        };
        cursor = {
          text = "#${config.colorscheme.palette.base00}";
          cursor = "#${config.colorscheme.palette.base06}";
        };
        vi_mode_cursor = {
          text = "#${config.colorscheme.palette.base00}";
          cursor = "#${config.colorscheme.palette.base07}";
        };
        search = {
          matches = {
            foreground = "#${config.colorscheme.palette.base00}";
            background = "#A5ADCE";
          };
          focused_match = {
            foreground = "#${config.colorscheme.palette.base00}";
            background = "#${config.colorscheme.palette.base0B}";
          };
          footer_bar = {
            foreground = "#${config.colorscheme.palette.base00}";
            background = "#A5ADCE";
          };
        };
        hints = {
          start = {
            foreground = "#${config.colorscheme.palette.base00}";
            background = "#${config.colorscheme.palette.base0A}";
          };
          end = {
            foreground = "#${config.colorscheme.palette.base00}";
            background = "#A5ADCE";
          };
        };
        selection = {
          text = "#${config.colorscheme.palette.base00}";
          background = "#${config.colorscheme.palette.base06}";
        };
        normal = {
          black = "#51576D";
          red = "#${config.colorscheme.palette.base08}";
          green = "#${config.colorscheme.palette.base0B}";
          yellow = "#${config.colorscheme.palette.base0A}";
          blue = "#${config.colorscheme.palette.base0D}";
          magenta = "#7b5cb0";
          cyan = "#${config.colorscheme.palette.base0C}";
          white = "#B5BFE2";
        };
        bright = {
          black = "#626880";
          red = "#${config.colorscheme.palette.base08}";
          green = "#${config.colorscheme.palette.base0B}";
          yellow = "#${config.colorscheme.palette.base0A}";
          blue = "#${config.colorscheme.palette.base0D}";
          magenta = "#a47de9";
          cyan = "#${config.colorscheme.palette.base0C}";
          white = "#A5ADCE";
        };
        dim = {
          black = "#51576D";
          red = "#${config.colorscheme.palette.base08}";
          green = "#${config.colorscheme.palette.base0B}";
          yellow = "#${config.colorscheme.palette.base0A}";
          blue = "#${config.colorscheme.palette.base0D}";
          magenta = "#F4B8E4";
          cyan = "#${config.colorscheme.palette.base0C}";
          white = "#B5BFE2";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#EF9F76";
          }
          {
            index = 17;
            color = "#${config.colorscheme.palette.base06}";
          }
        ];
      };
    };
  };
}
