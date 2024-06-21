# My nixos system flake

## system Flake

The name of the specific flake to build the system is `myNixos`. So to rebuild the system you need to type this command as root or with `sudo` :

```bash
sudo nixos-rebuild switch --flake ./#myNixos
```

## Iso image 

I added a flake to build a custom Iso image based on minimal image, but with some tools in order to try Nixos Everywhere. The name of the Flake is `customIso`, in order to build the Iso you have 2 options :

```bash
nix build .#nixosConfigurations.customIso.config.system.build.isoImage
```
