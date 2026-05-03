{
  lib,
  stdenvNoCC,
  fetchurl,
}:

# Placeholder — upstream switched to APFS DMGs which nixpkgs' undmg can't extract.
# Keep the package name available so callPackage resolves, but it won't build.
stdenvNoCC.mkDerivation {
  pname = "openclaw-app";
  version = "2026.5.2";

  src = fetchurl {
    url = "https://github.com/openclaw/openclaw/releases/download/v2026.5.2/OpenClaw-2026.5.2.dmg";
    hash = "sha256-lH06NxMmwc53GB1N28Pjx+p5cDMUDY5f//bp2YO2urc=";
  };

  unpackPhase = "echo 'openclaw-app: skipped (APFS DMG not supported by undmg)';";
  installPhase = ''
    mkdir -p "$out/Applications"
    echo "openclaw-app placeholder — DMG extraction not supported" > "$out/Applications/README.txt"
  '';

  meta = with lib; {
    description = "OpenClaw macOS app bundle (placeholder — APFS DMG not extractable)";
    homepage = "https://github.com/openclaw/openclaw";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
