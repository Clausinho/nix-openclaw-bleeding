{
  lib,
  stdenvNoCC,
  fetchurl,
  p7zip,
}:

let
  app_url = "https://github.com/openclaw/openclaw/releases/download/v2026.5.2/OpenClaw-2026.5.2.dmg";
  app_hash = "sha256-lH06NxMmwc53GB1N28Pjx+p5cDMUDY5f//bp2YO2urc=";
in
stdenvNoCC.mkDerivation {
  pname = "openclaw-app";
  version = "2026.5.2";

  src = fetchurl {
    url = app_url;
    hash = app_hash;
  };

  nativeBuildInputs = [ p7zip ];

  unpackPhase = ''
    runHook preUnpack
    7z x "$src" -o_dmg
    cd _dmg
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    app_path="$(find . -maxdepth 3 -name '*.app' -print -quit)"
    if [ -z "$app_path" ]; then
      echo "OpenClaw.app not found in DMG contents" >&2
      exit 1
    fi
    cp -R "$app_path" "$out/Applications/OpenClaw.app"
    runHook postInstall
  '';

  meta = with lib; {
    description = "OpenClaw macOS app bundle";
    homepage = "https://github.com/openclaw/openclaw";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
