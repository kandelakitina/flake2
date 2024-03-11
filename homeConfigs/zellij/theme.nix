{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:  {
  copyFromGlobal = {
    fg = config.colorscheme.base04;
    bg = config.colorscheme.base00;
    red = config.colorscheme.base08;
    green = config.colorscheme.base0B;
    yellow = config.colorscheme.base04;
    blue = config.colorscheme.base0D;
    magenta = config.colorscheme.base07;
    cyan = config.colorscheme.base0C;
    white = config.colorscheme.base04;
    orange = config.colorscheme.base09;
  };
}
