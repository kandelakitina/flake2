{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs = {
    
    bat.enable = true;
    btop.enable = true;
    
    eza = {
      enable = true;

      # ls, ll, la, lt, lla aliases
      enableAliases = true;
    };
    
    jq.enable = true;
    ripgrep.enable = true;
        
  };

  home.packages = with pkgs; [
    fd
    tree
    xclip
  ];
}
