{
  lib,
  fetchFromGitLab,
  python3Packages,
  glib,
  gobject-introspection,
  wrapGAppsHook3,
}:

python3Packages.buildPythonApplication {
  pname = "connman-notify";
  version = "2019-10-05";

  src = fetchFromGitLab {
    owner = "wavexx";
    repo = "connman-notify";
    rev = "24b10a51721b54d932f4cd61ef2756423768c015";
    hash = "sha256-EsF+Ckjojnn2o5PCDIexKrNIYxcIM1CZUNaTEIwvq8w=";
  };

  format = "other";

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsHook3
  ];

  buildInputs = [ glib ];

  pythonPath = with python3Packages; [
    dbus-python
    pygobject3
  ];

  strictDeps = false;

  installPhase = ''
    install -D -t $out/bin connman-notify
    install -D -t $out/share/doc README.rst
  '';

  meta = with lib; {
    description = "Desktop notification integration for connman";
    mainProgram = "connman-notify";
    homepage = "https://gitlab.com/wavexx/connman-notify";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ maintainers.romildo ];
  };
}
