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
