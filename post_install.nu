const file_name = '.sys-status.sqlite'
const packages = [ 
  ["root" "command" "packages"];
  [
    true
    ['pacman' '-S' '--needed']
    [
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
      go
      deno
      sd
      fd
      fzf
      git-delta
      starship
      ttf-fira-code
      nerd-fonts
      dosfstools
      tokei
      'openssl-1.1'
    ]
  ]
  [
    false
    ['cargo' 'install'] 
    [
      bat
      irust
      trunk 
      bacon  
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
    false
    ['paru' '-S' '--needed'] 
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
    false
    ['bun' 'install' '-g'] 
    [
      yaml-language-server
      vscode-langservers-extracted
      typescript-language-server
    ]
  ]
  [
    false
    ['rustup' 'component' 'add']
    [
      rust-src
      rust-analyzer
    ]
  ]
  [
    false
    ['rustup' 'target' 'add']
    [
      wasm32-unknown-unknown
    ]
  ]
  [
    false
    ['go' 'install']
    [
      "github.com/bufbuild/buf-language-server/cmd/bufls@latest"
    ]
  ]
]

def install_package [command_args : list<string>,package : string,--root (-r)] {
  alias runx = run-external --redirect-combine 
  let command = $command_args | first
  let arg1 = $command_args.1?
  let arg2 = $command_args.2?
  alias fun = if $root {
    if ($arg1 != null and $arg2 != null) {
      runx sudo $command $arg1 $arg2 $package 
    } else if $arg1 != null {
      runx sudo $command $arg1 $package 
    }
  } else {
    if ($arg1 != null and $arg2 != null) {
      runx $command $arg1 $arg2 $package 
    } else if $arg1 != null {
      runx $command $arg1 $package 
    }
  }
  fun | complete
}

def link-configs [] {
  open ~/magit/dotfiles/gitconfig out> ~/.gitconfig
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

def "main run" [] {
  if ('~/magit/dotfiles/.sys-status.sqlite' | path exists) {
    echo 'IMPORT'
    stor import --file-name $file_name
  } else {
    echo 'CREATE'
    stor create --table-name installed --columns {name : str, updated : bool}
    stor create --table-name failed --columns {name : str, message : str}
  }

  rm --force $file_name
  stor export --file-name $file_name
  stor reset
}

def "main test" [] {
  echo $packages 
}

def main [] {}
