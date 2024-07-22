{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = { 
        # optional, not necessary for the module
        nixpkgs.follows = "nixpkgs";
        # optionally choose not to download darwin deps (saves some resources on Linux)
        darwin.follows = "";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, disko, ... }: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
      	  disko.nixosModules.disko
          (import ./disko.nix { device = "/dev/nvme0n1"; })
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.${system}.default ]; }
          ./configuration.nix
	];
      };

      anywhere = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
      	  disko.nixosModules.disko
          ./anywhere.nix
        ];
      };

      customIso = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
      	  ./customIso/configuration.nix 
        ];
      };
    };
  };
}
