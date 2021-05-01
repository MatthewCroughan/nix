{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/sd-image-armv7l-multiplatform.nix"
  ];

  boot.kernelPackages = pkgs.lib.mkForce pkgs.linuxPackages_5_4; 
}
