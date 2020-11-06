{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, cmake
, qtbase
, obs-studio
}:

let metadata = import ./metadata.nix; in
stdenv.mkDerivation rec {
  pname = "obs-v4l2sink";
  version = "0.1.99";

  src = fetchFromGitHub {
    owner = "colemickens";
    repo = "obs-v4l2sink";
    rev = metadata.rev;
    sha256 = metadata.sha256;
  };
  #src = /home/cole/code/obs-v4l2sink;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ qtbase obs-studio ];

  # cmakeFlags = with lib; [
  #   "-DLIBOBS_INCLUDE_DIR=${obs-studio.src}/libobs"
  # ];

  # obs-studio expects the shared object to be located in bin/32bit or bin/64bit
  # https://github.com/obsproject/obs-studio/blob/d60c736cb0ec0491013293c8a483d3a6573165cb/libobs/obs-nix.c#L48
  postInstall = let
    pluginPath = {
      i686-linux = "bin/32bit";
      x86_64-linux = "bin/64bit";
      aarch64-linux = "bin/64bit";
    }.${stdenv.targetPlatform.system} or (throw "Unsupported system: ${stdenv.targetPlatform.system}");
  in ''
    true
    true; true; true
    mkdir -p $out/share/obs/obs-plugins/v4l2sink/${pluginPath}
    ln -s $out/lib/obs-plugins/v4l2sink.so $out/share/obs/obs-plugins/v4l2sink/${pluginPath}
  '';

  meta = with lib; {
    description = "obs studio output plugin for Video4Linux2 device";
    homepage = "https://github.com/colemickens/obs-v4l2sink";
    maintainers = with maintainers; [ colemickens peelz ];
    license = licenses.gpl2;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
