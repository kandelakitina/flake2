{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ...
  ];

  # v2ray - Proxy server
  services.v2ray.enable = true;
  
  # v2rayA - Proxy server web front end
  services.v2raya.enable = true;
}
