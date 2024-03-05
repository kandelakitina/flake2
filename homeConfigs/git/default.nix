{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

    programs.git = {
      enable = true;
      delta.enable = true;
      userName = "boticelli";
      userEmail = "kandelakitina@gmail.com";
    };
}
