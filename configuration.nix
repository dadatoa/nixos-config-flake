{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
      ./nas.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelModules = [ "88x2bu" ];

  boot.loader.efi.canTouchEfiVariables = true;
  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  
  # configure console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable experimental features 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow unfree packages 
  # nixpkgs.config.allowUnfree = true; # defined in flake

  environment.systemPackages = with pkgs; [
  git
  neovim
  curl
  wget
  nmap
  python3
  tailscale
  exfat
  btrfs-progs
  ];

  services = {
    # enable autorandr pour autodetect monitors 
    autorandr.enable = true;
    # Enable ssh
    openssh = {
      enable = true;
      openFirewall = true;
    };
    # Enable Tailscale
    tailscale.enable = true;
    
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      # dockerCompat = true; # conflict with docker
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      liveRestore = false; # docker swarm
        # rootless = {
        # enable = true;
        # setSocketVariable = true;
      # };
    };
  };
  

  system.stateVersion = "24.11";
}
