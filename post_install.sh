#!/run/current-system/sw/bin/bash

rustup default stable;

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

cp ~/magit/dotfiles/emacs/init.el ~/.emacs.d/;
ln ~/magit/dotfiles/xmonad/xmonad.hs ~/.config/xmonad/xmonad.hs;
ln ~/magit/dotfiles/bash_profile ~/.bash_profile
sudo ln ~/magit/dotfiles/configuration.nix /etc/nixos/configuration.nix;
