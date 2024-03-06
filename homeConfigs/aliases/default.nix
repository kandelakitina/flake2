{
  # Shell aliases
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
    nrs = "sudo nixos-rebuild switch --flake .#thinkpad";
    du = "dust";
    df = "duf";
    ps = "procs";

    # Eza has built-in aliases
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
