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
  };

  outputs = { self, nixpkgs, agenix }: 
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
      myNixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
      	  ./configuration.nix
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.${system}.default ]; }
	      ];
      };
      customIso = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
      	  ./customIso/configuration.nix 
      };
    };
  };
}
