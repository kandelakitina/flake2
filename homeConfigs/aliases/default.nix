{
  # Shell aliases
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
    nrs = "sudo nixos-rebuild switch --flake .#thinkpad";

    # Eza has built-in aliases
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
