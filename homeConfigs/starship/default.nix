{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = true;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
        cmd_duration = {
          disabled = true;
        };
        directory = {
          truncate_to_repo = true;
          format = "at [$path]($style)[$read_only]($read_only_style) ";
        };
      };
    };
}
