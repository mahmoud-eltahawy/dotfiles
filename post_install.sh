#!/run/current-system/sw/bin/bash

rustup default stable;

rustup component add \
    rust-src          \
    rust-analyzer      ;

rustup target add         \
    wasm32-unknown-unknown ;

cargo install \
    irust      \
    trunk       \
    bacon        \
    tauri-cli     \
    leptosfmt      \
    cargo-info      \
    cargo-leptos     \
    create-tauri-app  ;

ln ~/magit/dotfiles/xmonad/xmonad.hs ~/.config/xmonad/xmonad.hs;
ln ~/magit/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml;
ln ~/magit/dotfiles/nushell/config.nu ~/.config/nushell/config.nu;
ln ~/magit/dotfiles/nushell/env.nu ~/.config/nushell/env.nu;
ln ~/magit/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl;
ln ~/magit/dotfiles/leftwm/config.ron ~/.config/leftwm/config.ron
ln -s ~/magit/dotfiles/leftwm/theme ~/.config/leftwm/themes/current
ln ~/magit/dotfiles/bash_profile ~/.bash_profile

sudo ln ~/magit/dotfiles/configuration.nix /etc/nixos/configuration.nix;
