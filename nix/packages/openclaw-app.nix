{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation {
  pname = "openclaw-app";
  version = "2026.7.1";

  src = fetchzip {
    url = "https://github.com/openclaw/openclaw/releases/download/v2026.7.1/OpenClaw-2026.7.1.zip";
    hash = "sha256-9/r9AfggsxtVfaJB0/7g4Q3xz24nundH0w6t4DKivhU=";
    stripRoot = false;
  };

  dontUnpack = true;

  installPhase = "${../scripts/openclaw-app-install.sh}";

  meta = with lib; {
    description = "OpenClaw macOS app bundle";
    homepage = "https://github.com/openclaw/openclaw";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
