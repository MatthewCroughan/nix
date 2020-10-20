{ pkgs, lib, config, inputs, ... }:

{
  config = {
    hardware = {
      opengl = {
        driSupport32Bit = (pkgs.system=="x86_64-linux");
      };
    };
    programs.steam.enable = true;
  };
}