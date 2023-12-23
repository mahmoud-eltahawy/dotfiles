let packages = [ 
  ["command" "packages"];
  [
    "sudo pacman -S --needed"
    {
      "tauri": [
        webkit2gtk
        base-devel
        curl
        wget
        file
        openssl
        appmenu-gtk-module
        gtk3
        libappindicator-gtk3
        librsvg
        libvips
      ]
      "others":[
        go
        deno
        sd
        fd
        fzf
        zoxide
        git-delta
        starship
        ttf-fira-code
        nerd-fonts
        dosfstools
        tokei
        'openssl-1.1'
      ]
    }
  ]
  [
    "cargo install" 
    [
      bat
      irust
      trunk 
      bacon  
      zellij  
      du-dust   
      ripgrep    
      wiki-tui    
      taplo-cli    
      tauri-cli     
      leptosfmt        
      cargo-info
      cargo-watch      
      cargo-leptos       
      create-tauri-app
    ]
  ]
  [
    "paru -S --needed" 
    [
      unzip
      nodejs
      bun-bin
      lldb
      ntfs-3g
      marksman
      nitrogen
      picom
      thunar
      dmenu
      google-chrome
      libreoffice-still
      shutter    
      shotgun
      ffmpeg
      mpv
      pavucontrol
      feh
      slides
      sqlx-cli
      btop
      vifm
      dunst
      ttf-amiri
      ttf-arabeyes-fonts
      ttf-qurancomplex-fonts
    ]
  ]
  [
    "bun install -g" 
    [
      yaml-language-server
      vscode-langservers-extracted
      typescript-language-server
    ]
  ]
  [
    "rustup component add"
    [
      rust-src
      rust-analyzer
    ]
  ]
  [
    "rustups target add"
    [
      wasm32-unknown-unknown
    ]
  ]
  [
    "go install"
    [
      "github.com/bufbuild/buf-language-server/cmd/bufls@latest"
    ]
  ]
]

def link-configs [] {
  open ~/magit/dotfiles/gitconfig | save ~/.gitconfig
  echo "git configs done. pull git credentials next"
  
  # ln ~/magit/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl;
  ln ~/magit/dotfiles/leftwm/config.ron ~/.config/leftwm/config.ron
  ln -s ~/magit/dotfiles/leftwm/theme ~/.config/leftwm/themes/current
  ln ~/magit/dotfiles/bash_profile ~/.bash_profile
}

def install-basics [] {
  pacman -Syu
  pacman -S rustup
  rustup default stable
  cargo install sccache
  cargo install nu
  cd ~
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd ~
}

$packages 
