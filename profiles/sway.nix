{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    ./gui.nix
    
    ../mixins/gammastep.nix
    ../mixins/mako.nix
    ../mixins/sway.nix
    ../mixins/waybar.nix
  ];
  config = {
    home-manager.users.cole = { pkgs, ... }: {

      # block auto-sway reload, Sway crashes...
      xdg.configFile."sway/config".onChange = lib.mkForce "";

      home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";

        #WLR_DRM_NO_MODIFIERS = "1";
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";

        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "sway";
      };
      home.packages = with pkgs; [
        # sway-related
        drm_info
        grim
        #imv
        qt5.qtwayland
        slurp
        udiskie
        nwg-launchers
        wayvnc
        wf-recorder
        wl-clipboard
        wl-gammactl
        xwayland
      ];
    };
  };
}