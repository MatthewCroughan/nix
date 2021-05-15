{
  inputs = {
    crosspkgs = {
      #url = "github:Gaelan/nixpkgs/685f2f15f83445e2b8bda16f3812253a7fc6d3aa";
      url = "github:colemickens/nixpkgs/crosspkgs";
      #url = "github:nixos/nixpkgs/nixos-20.09";
    };
  };

  outputs = inputs:
    let
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [(./. + "/hosts/${hostname}/armv7l-linux.nix")];
          specialArgs = { inherit inputs; };
        };
    in rec {

    nixosConfigurations = {
      opizero  = mkSystem inputs.crosspkgs "x86_64-linux" "opizero";
    };

    images = {
      opizero = inputs.self.nixosConfigurations.opizero.config.system.build.sdImage;
    };
  };
}

