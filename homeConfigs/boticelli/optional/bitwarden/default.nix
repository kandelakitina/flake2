{
  pkgs,
  config,
  lib,
  ...
}: 
# let
#   pinentry =
#     if config.gtk.enable
#     then {
#       packages = [pkgs.pinentry-gnome pkgs.gcr];
#       name = "gnome3";
#     }
#     else {
#       packages = [pkgs.pinentry-curses];
#       name = "curses";
#     };
# in 
{
  # home.packages = pinentry.packages;
  home.packages = [pkgs.pinentry-curses];

  programs.rbw = {
    enable = true;
    settings = {
      email = "kandelakitina@gmail.com";
      # inherit (pinentry) name;
      pinentry = "curses";
    };
  };
}
