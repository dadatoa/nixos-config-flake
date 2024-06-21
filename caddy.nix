{ config, pkg, ... }:
{
# caddy for revers proxy 
  services.caddy = {
    enable = true;
    enableReload = true;
    virtualHosts."nara17.local".extraConfig = ''
      handle_path /jellyfin/* {
        reverse_proxy localhost:8096
        }
    '';
  };
}
