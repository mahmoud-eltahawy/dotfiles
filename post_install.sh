#!/run/current-system/sw/bin/bash

rustup default stable;
rustup toolchain add nightly;

cargo install \
    irust      \
    trunk       \
    bacon        \
    tauri-cli     \
    leptosfmt      \
    cargo-info      \
    cargo-leptos     \
    create-tauri-app  ;

rustup component add \
    rust-src          \
    rust-analyzer      ;

rustup target add         \
    wasm32-unknown-unknown ;
