{ config, pkgs, ... }:
{
  networking = {
    hostName = "nara17";
    ## enable networking config with network manager
    networkmanager.enable = true;
    ## firewall
    firewall = {
      enable = false; # for testing purpose
    };

    bridges = {
      "br0" = {
        interfaces = [ "enp2s0" "wlp0s20f0u5" ];
      };
    };
  };
}
