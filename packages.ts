const packages = {
  programs: {
    tauri: {
      pacman: [
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
      ],
      cargo: [
        "create-tauri-app",
        "tauri-cli",
      ],
    },
    emacs: {
      pacman: [
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
      ],
      npm: [
        "js-beautify",
      ],
    },
    xmonad: [
      "xmonad",
      "xmonad-contrib",
      "xmobar",
      "xterm",
      "dmenu",
    ],
  },
  aur: [
    "ttf-fira-code",
    "ttf-arabeyes-fonts",
    "gnome-alsamixer",
    "brave",
  ],
  get cargo() {
    return [
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
      "cargo-leptos",
      "leptosfmt",
      "trunk",
      "paru",
      ...this.programs.tauri.cargo,
    ];
  },
  get pacman() {
    return [
      "xorg",
      "picom",
      "nitrogen",
      "alacritty",
      "btop",
      "vifm",
      "mpv",
      "vlc",
      "nodejs",
      "npm",
      "unzip",
      ...this.programs.xmonad,
      ...this.programs.emacs.pacman,
      ...this.programs.tauri.pacman,
    ];
  },
  get npm() {
    return [
      ...this.programs.emacs.npm,
    ];
  },
  install: async function () {
    await Deno.run({
      cmd: ["sudo", "pacman", "-S", "--needed", ...this.pacman],
    }).status();
    await Deno.run({ cmd: ["cargo", "install", ...this.cargo] }).status();
    await Deno.run({ cmd: ["paru", "-S", ...this.aur] }).status();
    await Deno.run({ cmd: ["sudo", "npm", "install", "-g", ...this.npm] })
      .status();
  },
};

const rust = {
  targets: [
    "wasm32-unknown-unknown",
  ],
  components: [
    "rust-analyzer",
  ],
  install: async function () {
    const s = Deno.run({
      cmd: ["curl", "https://sh.rustup.rs"],
      stdout: "piped",
    });
    await s.status();
    const script = new TextDecoder().decode(await s.output());
    const file_path = "./tmp_install_script";
    await Deno.create(file_path);
    await Deno.writeTextFile(file_path, script);
    await Deno.run({ cmd: ["sh", file_path] }).status();
    await Deno.remove(file_path);
    await Deno.run({ cmd: ["source", "'$HOME/.cargo/env'"] }).status();
    await Deno.run({ cmd: ["rustup", "target", "add", ...this.targets] })
      .status();
    await Deno.run({ cmd: ["rustup", "component", "add", ...this.components] })
      .status();
  },
};

await rust.install();
await packages.install();
await install_doom_emacs();

async function install_doom_emacs() {
  const emacsHome = await Deno.env.get("HOME") + "/.config/emacs";
  await Deno.run({
    cmd: [
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/doomemacs/doomemacs",
      emacsHome,
    ],
  }).status();
  await Deno.run({
    cmd: [
      `${emacsHome}/bin/doom`,
      "install",
    ],
  }).status();
}
