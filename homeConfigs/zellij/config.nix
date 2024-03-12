{colorScheme}: {
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
  #         action = {SwitchToMode = "Normal";};
  #       }
  #     ];
  #   };
  #   resize = {
  #     clearDefaults = true;
  #     bind = [
  #       {
  #         key = "Alt r";
  #         action = "Esc";
  #         additionalAction = "Ctrl {";
  #         postAction = {SwitchToMode = "Normal";};
  #       }
  #       # Additional bindings...
  #     ];
  #   };
  #   # Additional modes and bindings...
  # };
}
