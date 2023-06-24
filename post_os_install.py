#!/usr/bin/env python3
import os

home = os.getenv("HOME")

cargos = [
    "irust",
    "bacon",
    "cargo-info",
    "cargo-leptos",
    "leptosfmt",
    "trunk",
    "create-tauri-app",
    "tauri-cli",
]

pips = [
    "pipe",
    "pandas",
    "openpyxl"
]


def rust_install():
    targets = [
        "wasm32-unknown-unknown",
    ]
    components = [
        "rust-analyzer",
        "rust-src",
    ]

    os.system("rustup default stable")
    os.system("rustup toolchain add nightly")
    os.system("cargo install " + " ".join(cargos))
    os.system("rustup target add " + " ".join(targets))
    os.system("rustup component add " + " ".join(components))


def python_install():
    os.system(f"python -m venv {home}/.python")
    os.system(f"{home}/.python/bin/pip install " + " ".join(pips))

rust_install()
python_install()
