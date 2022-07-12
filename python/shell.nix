{ pkgs ? import (builtins.fetchTarball "channel:nixpkgs-unstable") {}
}:

let
  pyEnv = pkgs.python310.withPackages (p: with p; [
    pylint black
    ipython notebook
    numpy pandas
    matplotlib networkx

    tkinter
    pyqt5 pyqt5_sip
  ]);
in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pyEnv
    libsForQt5.qt5.full
  ];

  PYTHONPATH = "${pyEnv}/bin/python";
  PYTHONLIBS = "${pyEnv}/lib/python3.10/site-packages/";
}
