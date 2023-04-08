const cargo_packages = [
  "sccache",
  "exa",
  "du-dust",
  "nu",
  "bat",
  "zellij",
  "irust",
  "ripgrep",
  "bacon",
  "cargo-info",
  "wiki-tui",
  "trunk",
  "create-tauri-app",
  "paru",
];

const pacman_packages = [
  "xorg",
  "emacs-nativecomp",
  "picom",
  "nitrogen",
  "dmenu",
  "alacritty",
  "xterm",
  "fish",
  "btop",
  "vifm",
  "mpv",
  "vlc",
  "fd",
  "shellcheck",
  "cmake",
  "tidy",
  "stylelint",
  "jq",
  "xclip",
  "maim",
  "xmonad",
  "xmonad-contrib",
  "xmobar",
  "nodejs",
  "npm",
];

const aur_packages = [
  "otf-fira-code-git"
];

await install_rust();
await Deno.run({ cmd: ["cargo", "install", ...cargo_packages] }).status();
await Deno.run({ cmd: ["sudo", "pacman", "-S", ...pacman_packages] }).status();
await Deno.run({ cmd: ["paru", "-S", ...aur_packages] }).status();
await install_doom_emacs();

async function install_rust() {
  const s = Deno.run({ cmd: ["curl", "https://sh.rustup.rs"], stdout: "piped" });
  await s.status();
  const script = new TextDecoder().decode(await s.output());
  const file_path = "./tmp_install_script";
  await Deno.create(file_path);
  await Deno.writeTextFile(file_path, script);
  await Deno.run({ cmd: ["sh", file_path] }).status();
  await Deno.remove(file_path);
}

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
