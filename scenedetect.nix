{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
    name = "scenedetect-shell";
    targetPkgs = pkgs: (with pkgs; [
        (python310.withPackages (p: with p; [
            numpy
            platformdirs
            click
            opencv4
            (buildPythonPackage rec {
                pname = "scenedetect";
                version = "0.6.2";
                format = "wheel";
                src = fetchPypi {
                    inherit pname version;
                    format = "wheel";
                    python = "py3";
                    dist = "py3";
                    sha256 = "sha256-7wUt5Flnbej0A/eJh/TEhEvKeVRBAOadTb00Ql1ypC4=";
                };
                doCheck = false;
            })
        ]))
        ffmpeg
        mkvtoolnix
        zlib
        libGLU
    ]);
    runScript = "zsh";
}).env