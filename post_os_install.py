#!/usr/bin/env python3
import os

#------------------------------------------------------------------------------------>
#------------INSTALL FUNCTIONS------------------------------------------------------->
#------------------------------------------------------------------------------------>
dnfs = []
cargos = []
npms = []

def dnfs_install(packages):
    dnfs.extend(packages)

def npm_install(packages):
    npms.extend(packages)

def cargo_install(packages):
    cargos.extend(packages)

def brave_install():
    os.system("sudo dnf install dnf-plugins-core")
    os.system("sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo")
    os.system("sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc")
    os.system("sudo dnf install brave-browser brave-keyring")

def packages_install():
    os.system('sudo dnf group install "C Development Tools and Libraries"')
    os.system("sudo dnf install " + " ".join(dnfs))
    brave_install()
    os.system("sudo npm install -g " + " ".join(npms))
    os.system("cargo install " + " ".join(cargos))


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
    os.system("source $HOME/.cargo/env")
    os.system("rustup target add " + " ".join(targets))
    os.system("rustup component add " + " ".join(components))

#------------------------------------------------------------------------------------>
#------------Haskell----------------------------------------------------------------->
#------------------------------------------------------------------------------------>

dnfs_install([
    "gcc",
    "gcc-c++",
    "gmp",
    "gmp-devel",
    "make",
    "ncurses",
    "ncurses-compat-libs",
    "xz",
    "perl",
])

def haskell_install():
    os.system("curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | bash")

#------------------------------------------------------------------------------------>
#------------BASIC PACKAGES---------------------------------------------------------->
#------------------------------------------------------------------------------------>

dnfs_install([
    "btop",
    "vifm",
    "mpv",
    "nodejs",
    "npm",
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
dnfs_install([
    "pipenv",
    "python3-nose",
    "python3-isort",
    "python3-pytest",
])

# TAURI DEVELOPMENT
dnfs_install([
    "webkit2gtk4.0-devel",
    "curl",
    "wget",
    "openssl-devel",
    "libappindicator-gtk3",
    "librsvg2-devel",
])
cargo_install([
    "create-tauri-app",
    "tauri-cli",
])

# XMONAD
dnfs_install([
    "libX11-devel",
    "libXft-devel",
    "libXinerama-devel",
    "libXrandr-devel",
    "libXScrnSaver-devel",
    "xmonad",
    "ghc-xmonad-contrib",
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

dnfs_install([
    "emacs",
    "fd-find",
    "ShellCheck",
    "cmake",
    "tidy",
    "jq",
    "xclip",
    "maim",
    "ripgrep",
    "wl-clipboard",
])
npm_install([
    "js-beautify",
    "marked",
    "stylelint",
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
haskell_install()
