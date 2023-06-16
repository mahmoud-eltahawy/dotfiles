#!/usr/bin/env python3
import os

#------------------------------------------------------------------------------------>
#------------INSTALL FUNCTIONS------------------------------------------------------->
#------------------------------------------------------------------------------------>
pacmans = []
aurs = []
cargos = []
npms = []

def pacman_install(packages):
    pacmans.extend(packages)

def npm_install(packages):
    npms.extend(packages)

def paru_install(packages):
    aurs.extend(packages)

def cargo_install(packages):
    cargos.extend(packages)

def packages_install():
    os.system("sudo pacman -S --needed " + " ".join(pacmans))
    os.system("sudo npm install -g " + " ".join(npms))
    os.system("cargo install " + " ".join(cargos))
    os.system("paru -S " + " ".join(aurs))

#------------------------------------------------------------------------------------>
#------------RUST-------------------------------------------------------------------->
#------------------------------------------------------------------------------------>

def rust_install():
    targets = [
        "wasm32-unknown-unknown",
    ]
    components = [
        "rust-analyzer",
    ]
    os.system("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash")
    os.system("source '$HOME/.cargo/env'")
    os.system("rustup target add " + " ".join(targets))
    os.system("rustup component add " + " ".join(components))

#------------------------------------------------------------------------------------>
#------------BASIC PACKAGES---------------------------------------------------------->
#------------------------------------------------------------------------------------>

pacman_install([
    "xorg",
    "btop",
    "vifm",
    "mpv",
    "vlc",
    "nodejs",
    "npm",
    "unzip",
])

cargo_install([
    "sccache",
    "exa",
    "du-dust",
    "nu",
    "bat",
    "zellij",
    "irust",
    "bacon",
    "wiki-tui",
    "cargo-info",
    "paru",
])

paru_install([
    "ttf-fira-code",
    "ttf-arabeyes-fonts",
    "gnome-alsamixer",
    "brave-bin",
])


#------------------------------------------------------------------------------------>
#------------WINDOW MANGER AND DEVELOPMENT DEPENDENCIES------------------------------>
#------------------------------------------------------------------------------------>

# LEPTOS DEVELOPMENT
cargo_install([
    "cargo-leptos",
    "leptosfmt",
    "trunk",
])

# PYTHON DEVELOPMENT
pacman_install([
    "python-pipenv",
    "python-nose",
    "python-isort",
])
paru_install([
    "python-conda"
])

# TAURI DEVELOPMENT
pacman_install([
    "webkit2gtk",
    "base-devel",
    "curl",
    "wget",
    "openssl",
    "appmenu-gtk-module",
    "gtk3",
    "libappindicator-gtk3",
    "librsvg",
    "libvips",
])
cargo_install([
    "create-tauri-app",
    "tauri-cli",
])

# XMONAD
pacman_install([
    "xmonad",
    "xmonad-contrib",
    "xmobar",
    "xterm",
    "dmenu",
    "alacritty",
    "picom",
    "nitrogen",
])

#------------------------------------------------------------------------------------>
#------------DOOMEMACS--------------------------------------------------------------->
#------------------------------------------------------------------------------------>

pacman_install([
    "emacs-nativecomp",
    "fd",
    "shellcheck",
    "cmake",
    "tidy",
    "stylelint",
    "jq",
    "xclip",
    "maim",
    "ripgrep",
])
npm_install([
    "js-beautify",
])

def doomemacs_install():
    os.system("git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs")
    os.system("~/.config/emacs/bin/doom install")

#------------------------------------------------------------------------------------>
#------------ACTION------------------------------------------------------------------>
#------------------------------------------------------------------------------------>

rust_install()
packages_install()
doomemacs_install()
