{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "vhdl-ls";
  version = "0.83.1";

  src = fetchFromGitHub {
    owner = "VHDL-LS";
    repo = "rust_hdl";
    rev = "v${version}";
    hash = "sha256-AO95J138d3m8CpJ7hWYeGP+rRd2009qQXwLxbuHDSDs=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-7+isSSjF4V1FQaWRzmNAAW0q3/x/Tqkt8jNzGXsJHAo=";

  postPatch = ''
    substituteInPlace vhdl_lang/src/config.rs \
      --replace /usr/lib $out/lib
  '';

  postInstall = ''
    mkdir -p $out/lib/rust_hdl
    cp -r vhdl_libraries $out/lib/rust_hdl
  '';

  meta = {
    description = "Fast VHDL language server";
    homepage = "https://github.com/VHDL-LS/rust_hdl";
    license = lib.licenses.mpl20;
    mainProgram = "vhdl_ls";
    maintainers = with lib.maintainers; [ doronbehar ];
  };
}
