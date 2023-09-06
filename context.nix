with import <nixpkgs> {}; stdenv.mkDerivation {
  pname = "LuaMetaTeX";
  version = "2.10.11";

  src = fetchzip {
    url = "https://www.pragma-ade.nl/context/latest/cont-lmt.zip";
    sha256 = "eXTV39QvSrfz7WgcaHXvL8AW+saD3WDA1Nmbwp6M3cg=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    cmake
    coreutils
    gcc
    gnumake
    ninja
  ];

  configurePhase = ''
    cmake "$src/source/luametatex/"
  '';

  buildPhase = ''
    make all
  '';

  installPhase = ''
    mkdir -p "$out/bin"
    cp luametatex "$out/bin/"
    cp -r scripts "$out/scripts"
    ln -s "$out/bin/luametatex --lua=$out/scripts/context/lua/mtxrun.lua" "$out/bin/mtxrun"
    ln -s "$out/bin/luametatex --lua=$out/scripts/context/lua/context.lua" "$out/bin/context"
  '';
}
