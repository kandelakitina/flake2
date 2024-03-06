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

    # better trees navigating
    broot = {
      enable = true;
      enableFishIntegration = true;
    };
    
    eza = {
      enable = true;
      icons = true;
      git = true;

      # ls, ll, la, lt, lla aliases
      enableAliases = true;
    };

    # better ctrl-r history search
    mcfly = {
      enable = true;
      enableFishIntegration = true;
    };
    
    jq.enable = true;
    ripgrep.enable = true;

    thefuck = {
      enable = true;
      enableFishIntegration = true;
    };
        
  };

  home.packages = with pkgs; [
    fd              # better find
    choose          # a better cut / awk
    curlie          # curl + httpie
    du-dust         # see file trees ('dust')
    duf             # better 'df' (disk usage)
    gdu             # disk usage (folders)
    # dogdns             # a CLI dns client
    httpie          # CLI HTTP client for APIs access
    ouch            # better unzip
    procs           # better ps
    sd              # better sed
    silver-searcher # 'ag' (code search)
    tree
    xclip
    xh              # sending HTTP requests in CLi
    xxh             # bring your shell with you upon SSH
  ];

  home.shellAliases = {
    du = "dust";
    df = "duf";
    ps = "procs";
  };
}
