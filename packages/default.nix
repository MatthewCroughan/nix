self: pkgs:

let colePackages = {
  customCommands = pkgs.callPackages ./commands.nix {};
  customGuiCommands = pkgs.callPackages ./commands-gui.nix {};

  alps = pkgs.callPackage ./alps {};
  mirage-im = pkgs.libsForQt5.callPackage ./mirage-im {};
  neovim-unwrapped = pkgs.callPackage ./neovim {
    neovim-unwrapped = pkgs.neovim-unwrapped;
  };
  passrs = pkgs.callPackage ./passrs {};

  raspberrypi-eeprom = pkgs.callPackage ./raspberrypi-eeprom {};
  
  rpi4-uefi = pkgs.callPackage ./rpi4-uefi {};
};
in
  colePackages // { inherit colePackages; }