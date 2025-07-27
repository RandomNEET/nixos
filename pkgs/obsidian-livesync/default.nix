{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "obsidian-livesync";
  version = "0.24.31";
  src = null;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    cp ${
      pkgs.fetchurl {
        url = "https://github.com/vrtmrz/obsidian-livesync/releases/download/0.24.31/main.js";
        sha256 = "fc53a5072ebcf68856a5cc154939d92b09546ff0e3afbfa8a2ed27678aebac45";
      }
    } $out/main.js

    cp ${
      pkgs.fetchurl {
        url = "https://github.com/vrtmrz/obsidian-livesync/releases/download/0.24.31/manifest.json";
        sha256 = "3d4adc5fe4f569723b5be76d4db5c66e8cec767217e51f56c41a19134f756290";
      }
    } $out/manifest.json

    cp ${
      pkgs.fetchurl {
        url = "https://github.com/vrtmrz/obsidian-livesync/releases/download/0.24.31/styles.css";
        sha256 = "c7178a18f27483a29c353f7227bbb96ac915b3a5a21445d25d5b5f06d3217c02";
      }
    } $out/styles.css
  '';
}
