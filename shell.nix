{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  inherit (lib) optional optionals;
  rust_overlay = import (builtins.fetchTarball https://github.com/oxalica/rust-overlay/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ rust_overlay ]; };
in

mkShell {
  buildInputs = [
    bash
    git
    gnumake
    openssl
    pkg-config
    rebar3
    glibcLocales
    python38
    beam.packages.erlangR23.elixir_1_12
    nixpkgs.rust-bin.stable."1.62.0".default
    nodejs-16_x
    curl
  ]
  ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    # For file_system on macOS.
    #Adds some libraries needed to compile the project in mac
    AppKit
  ]);
  
  shellHook = '' 
      export PATH="$PWD/aleo/target/release:$PATH"
    '';
}
