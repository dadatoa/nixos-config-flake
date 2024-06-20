{ config, pkgs, ... }:

{
  users = {
    users.dadato = {
      isNormalUser = true;
      uid = 1000;
      description = "individual user";
      extraGroups = [ "networkmanager" "docker" ];
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"];
      packages = with pkgs; [];
      };

    users.dadatoa = {
      isNormalUser = true;
      description = "admin system";
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"];
      packages = with pkgs; [];
      };

    # users.bill = {
    #  isNormalUser = true;
    #  description = "services manager";
    #  extraGroups = [ "docker" "networkmanager" ];
    #  openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"];
    #  packages = with pkgs; [];
    #  };
    
    };

  # no sudo password for dadatoa 
  # no password is set for this account
  # should only be accessed threw ssh with ssh key
  security.sudo.extraRules = [
  {
    users = [ "dadatoa" ];
    commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
  }
  ];

  # autologin user dadato at startup on tty
  # services.getty.autologinUser = "dadato"; 

}
