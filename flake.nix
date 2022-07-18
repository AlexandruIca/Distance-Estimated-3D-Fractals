{
  description = "Rust environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in with pkgs; rec {
      devShell = mkShell rec {
        buildInputs = [
          rustc
          cargo
          rustfmt
          clippy
          rust-analyzer

          libxkbcommon
          libGL

          # WINIT_UNIX_BACKEND=x11
          xorg.libxcb
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXi
          xorg.libX11
        ];
        LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
          shellHook = ''
            export PS1="$PS1\[\033[38;2;211;134;155m\]:nix:\[\033[0m\] "
          '';
      };
    });
}
