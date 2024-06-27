{ config, pkgs, ... }:
{
  services = {
    # Enable ssh
    openssh = {
      enable = true;
      openFirewall = true;
    };
    
    # Enable Tailscale
    tailscale.enable = true;

    # caddy reverse proxy
    caddy = {
      enable = true;
      enableReload = true;
      virtualHosts."jellyfin.nara17.local".extraConfig = ''
        reverse_proxy localhost:8096
      '';
    #   handle_path /jellyseerr* {
    #     reverse_proxy localhost:5055
    #     }
      virtualHosts."prowlarr.nara17.local".extraConfig = ''
        reverse_proxy localhost:9696
      '';
    #   handle_path /radarr* {
    #     reverse_proxy localhost:7878
    #     }
    #   handle_path /sonarr* {
    #     reverse_proxy localhost:8989
    #     }
    #   handle_path /bazarr* {
    #     reverse_proxy localhost:6767
    #     }
    #   handle_path /unison* {
    #     reverse_proxy localhost:9091
    #     }
    #   handle_path /uptime* {
    #     reverse_proxy localhost:3001
    #     }
    #   handle_path /dockge* {
    #     reverse_proxy localhost:5001
    #     }
    # '';
    };
};

 networking = {
    hostName = "nara17";

    ## enable networking config with network manager
    networkmanager.enable = true;

    ## firewall
    firewall = {
      enable = false; # for testing purpose
    #   allowedTCPPorts = [
    #     80
    #     443
    #     9091
    #     51413
    #     3689
    #     9696
    #     7878
    #     8989
    #     6767
    #     ];
    #   allowedTCPPortRanges = [
    #     { from = 2000; to = 3000; }
    #   ];
    #   allowedUDPPortRanges = [
    #     { from = 51400; to = 51500; }
    #     # { from = 8000; to = 8010; }
    #    ];
    };
  };
}
