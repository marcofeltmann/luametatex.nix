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
    echo "prepare tooling file structure"
    mkdir -p "$out/tex/texmf-context" "$out/tex/texmf-linux-64/bin"
    cp -r colors "$out/tex/texmf-context/"
    cp -r context "$out/tex/texmf-context/"
    cp -r doc "$out/tex/texmf-context/"
    cp -r fonts "$out/tex/texmf-context/"
    cp -r metapost "$out/tex/texmf-context/"
    cp -r scripts "$out/tex/texmf-context/"
    cp -r tex "$out/tex/texmf-context/"
    cp -r web2c "$out/tex/texmf-context/"
    mv "$out/tex/texmf-context/web2c/contextcnf.lua" "$out/tex/texmf-context/web2c/texmfcnf.lua"

    echo "prepare binaries"
    cp luametatex "$out/tex/texmf-linux-64/bin/"
    ln -s "$out/tex/texmf-linux-64/bin/luametatex" "$out/tex/texmf-linux-64/bin/mtxrun"
    cp scripts/context/lua/mtxrun.lua "$out/tex/texmf-linux-64/bin/mtxrun.lua"
    ln -s "$out/tex/texmf-linux-64/bin/luametatex" "$out/tex/texmf-linux-64/bin/context"
    cp scripts/context/lua/context.lua "$out/tex/texmf-linux-64/bin/context.lua"
  '';
}
