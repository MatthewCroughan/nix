{ pkgs, lib, modulesPath, inputs, config, ... }:

{
  imports = [
    ./configuration.nix
    "${modulesPath}/installer/cd-dvd/sd-image-armv7l-multiplatform.nix"
  ];

  nixpkgs.crossSystem = {
    system = "armv7l-linux";
  };
#  nixpkgs.crossSystem = lib.systems.examples.armv7l-hf-multiplatform;

  boot.kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_5_4;
}
