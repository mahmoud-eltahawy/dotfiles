#!/usr/bin/bash

# tauri dependencies
sudo pacman -Syu
sudo pacman -S --needed \
    webkit2gtk \
    base-devel \
    curl \
    wget \
    file \
    openssl \
    appmenu-gtk-module \
    gtk3 \
    libappindicator-gtk3 \
    librsvg \
    libvips

sudo pacman -S rustup;

rustup default stable;

rustup component add \
    rust-src          \
    rust-analyzer      ;

rustup target add         \
    wasm32-unknown-unknown ;

cargo install sccache;
cargo install \
    bat        \
    exa         \
    irust        \
    trunk         \
    bacon          \
    zellij          \
    nushell          \
    du-dust           \
    ripgrep            \
    wiki-tui            \
    taplo-cli            \
    tauri-cli             \
    leptosfmt              \  
    cargo-info              \  # not installed
    cargo-leptos             \ # not installed
    create-tauri-app          ;



cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~

paru -S unzip \
    lldb \
    ntfs-3g \
    marksman \
    nitrogen \
    picom \
    thunar \
    dmenu \
    google-chrome \
    libreoffice-still \
    shutter \    
    shotgun \
    ffmpeg \
    mpv \
    pavucontrol \
    feh \
    slides \
    sqlx-cli \
    btop \
    vifm \
    jq \
    dunst \
    cloc \
    nodejs \
    npm ;


bun install -g yaml-language-server
    bash-language-server
    typescript-language-server;

ln ~/magit/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl;
ln ~/magit/dotfiles/helix/config.toml ~/.config/helix/config.toml
ln ~/magit/dotfiles/leftwm/config.ron ~/.config/leftwm/config.ron
ln -s ~/magit/dotfiles/leftwm/theme ~/.config/leftwm/themes/current
ln ~/magit/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml;
ln ~/magit/dotfiles/nushell/config.nu ~/.config/nushell/config.nu;
ln ~/magit/dotfiles/nushell/env.nu ~/.config/nushell/env.nu;
ln ~/magit/dotfiles/bash_profile ~/.bash_profile
