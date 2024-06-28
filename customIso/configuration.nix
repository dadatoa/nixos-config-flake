{ config, lib, pkgs, modulesPath, ... }: {
imports = [
  "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
];

## platform 
nixpkgs.hostPlatform = "x86_64-linux";

# Load drivers for mac intel wifi
boot.initrd.kernelModules = [ "wl" ];

# Load driers for mac intel & tplink archer wifi
boot.kernelModules = [ "88x2bu" "kvm-intel" "wl" ];
boot.extraModulePackages = [
  # broadcom for macos intel wifi
  config.boot.kernelPackages.broadcom_sta
  # rt88x2bu for tplink archer wifi wih monitoring mode enabled
  (config.boot.kernelPackages.rtl88x2bu.overrideAttrs (old: {
    prePatch = old.prePatch + ''
      substituteInPlace Makefile --replace "CONFIG_CONCURRENT_MODE = n" "CONFIG_CONCURRENT_MODE = y"
    '';
  }))
];

environment.systemPackages = with pkgs; [
  git
  curl
  wget
  python3
  ansible
  neovim
];

# Enable networking
networking.networkmanager.enable = true;
networking.wireless.enable = false;

# Enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Enable proprietary hardware
nixpkgs.config.allowUnfree = true;

# SSh key for nixos default account
users.users.nixos.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab" ];
users.users.nixos.initialPassword = "nixos";

# Enable ssh
services.openssh = {
  enable = true;
};
# bigger image, shorter compilation time
isoImage.squashfsCompression = "lz4";

}
