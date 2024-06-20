{ config, pkgs, ... }:
{
  
  # List services that you want to enable:
  services = {
    # Enable ssh
    openssh = {
      enable = true;
      openFirewall = true;
    };
    # Enable Tailscale
    tailscale.enable = true;
    # caddy for revers proxy 
    caddy = {
      enable = true;
      enableReload = true;
      virtualHosts."nara17.local".extraConfig = ''
        handle_path /jellyfin/* {
          reverse_proxy localhost:8096
      '';
    };
    # Enable samba
    samba = {
      package = pkgs.samba4Full;
      enable = true;
      openFirewall = true;
      extraConfig = ''
      workgroup = WORKGROUP
      security = user
      guest account = nobody
      '';
      shares = {
        share = {
          path = /mnt/share;
          writable = "yes";
          browseable = "yes";
          "guest ok" = "yes";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
      };
    };
    # enable Avahi
    avahi = {
      publish = {
        enable = true;
        userServices = true;
      };
      enable = true;
      openFirewall = true;
    };
    # samba-wsdd for autodiscovery on windows
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
    ## servarr config 
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
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    
    # ...
  };

  networking = { 
    hostName = "nara17";

    ## enable networking config with network manager
    networkmanager.enable = true;
    
    ## firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [ 
        80
        443
        9091
        51413 
        3689 
        9696 
        7878 
        8989 
        6767
        ];
      allowedTCPPortRanges = [
        { from = 2000; to = 3000; }   
      ];
      allowedUDPPortRanges = [
        { from = 51400; to = 51500; }
        # { from = 8000; to = 8010; }
       ]; 
    };
  };

}
