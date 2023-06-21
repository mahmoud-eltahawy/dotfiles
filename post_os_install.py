#!/usr/bin/env python3
import os

# ----------------------------------------------------------------------------------->
# INSTALL FUNCTIONS------------------------------------------------------->
# ----------------------------------------------------------------------------------->
pacmans = []
aurs = []
cargos = []
npms = []

home = os.getenv("HOME")


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
    os.system("cargo install sccache")
    os.system("cargo install " + " ".join(cargos))
    os.system("paru -S " + " ".join(aurs))

# ----------------------------------------------------------------------------------->
# RUST
# ----------------------------------------------------------------------------------->


def rust_install():
    targets = [
        "wasm32-unknown-unknown",
    ]
    components = [
        "rust-analyzer",
        "rust-src",
    ]

    command = "curl https://sh.rustup.rs -sSf | sh -s -- -y  --component {} --target {}"
    os.system(command.format(" ".join(components), " ".join(targets)))
    os.system('source "{}/.cargo/env"'.format(home))
    os.system("rustup toolchain add nightly")
    os.system("cargo +nightly install racer")

# ----------------------------------------------------------------------------------->
# BASIC PACKAGES---------------------------------------------------------->
# ----------------------------------------------------------------------------------->


pacman_install([
    "xorg",
    "btop",
    "vifm",
    "mpv",
    "vlc",
    "nodejs",
    "npm",
    "unzip",
    "ttf-nerd-fonts-symbols",
    "ttf-nerd-fonts-symbols-mono",
])

cargo_install([
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


# ----------------------------------------------------------------------------------->
# WINDOW MANGER AND DEVELOPMENT DEPENDENCIES
# ----------------------------------------------------------------------------------->

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


def python_install():
    packages = [
        "pipe",
        "pandas",
        "openpyxl"
    ]
    os.system("python -m venv {}/.python".format(home))
    os.system("pip install python-lsp-server[all]")
    os.system("{}/.python/bin/pip install ".join(home) + " ".join(packages))


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

# ----------------------------------------------------------------------------------->
# DOOMEMACS
# ----------------------------------------------------------------------------------->

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
    os.system("{}/.config/emacs/bin/doom install".format(home))

# ----------------------------------------------------------------------------------->
# ACTION
# ----------------------------------------------------------------------------------->


rust_install()
packages_install()
doomemacs_install()

