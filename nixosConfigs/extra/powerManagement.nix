{
  config,
  lib,
  ...
}:
{
  services.upower.enable = true;
  services.upower.criticalPowerAction = "Hibernate";
  services.power-profiles-daemon.enable = true;
}
