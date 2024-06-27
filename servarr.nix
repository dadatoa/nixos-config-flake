{ config, pkgs, ...}:
{
  services = {
    # prowlarr 
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    # radarr 
    radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/data/appdata/radarr";
      user = "dadato";
      group = "users";
    };
    # sonarr
    sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/data/appdata/sonarr";
      user = "dadato";
      group = "users";
    };
    # bazarr
    bazarr = {
      enable = true;
      openFirewall = true;
      user = "dadato";
      group = "users";
    };
    # jellyfin
    jellyfin = {
      enable = true;
      openFirewall = true;
      user = "dadato";
      group = "users";
      dataDir = "/data/appdata/jelly";
    };
    # jellyseerr
    # jellyseerr = {
    #   enable = true;
    #   openFirewall = true;
    # };
  };
}
