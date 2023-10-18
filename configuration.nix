# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).



{ config, pkgs, ... }:

let unstableTarball =
  fetchTarball
    https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;

in
{

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_EG.UTF-8";
    LC_IDENTIFICATION = "ar_EG.UTF-8";
    LC_MEASUREMENT = "ar_EG.UTF-8";
    LC_MONETARY = "ar_EG.UTF-8";
    LC_NAME = "ar_EG.UTF-8";
    LC_NUMERIC = "ar_EG.UTF-8";
    LC_PAPER = "ar_EG.UTF-8";
    LC_TELEPHONE = "ar_EG.UTF-8";
    LC_TIME = "ar_EG.UTF-8";
  };

  virtualisation.docker.enable = true;
  
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";
    xkbVariant = "";
    windowManager.leftwm.enable = true;
    displayManager = {
      defaultSession = "none+leftwm";
      lightdm = {
          greeters.enso = {
          enable = true;
          blur = true;
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eltahawy = {
    isNormalUser = true;
    description = "eltahawy";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "eltahawy";

  nix.settings.trusted-users = ["root" "eltahawy"];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };  
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    dunst
    cloc

    pandoc
    ffmpeg
    gimp
    # unstable.surrealdb
    unstable.bun
    polybar
    alacritty
    gitui
    lldb
    jq
    helix
    xclip
    vifm-full
    btop
    unzip
    sqlx-cli
    slides

    feh
    mpv
    obs-studio
    pavucontrol
    shutter    
    shotgun

    google-chrome
    dbeaver
    libreoffice-still

    xfce.thunar
    dmenu

    curl
    wget
    git

    gcc
    cmake

    rustup
    taplo-cli
    bat
    nushell
    zellij
    du-dust
    ripgrep
    exa
    wiki-tui
    sccache

    unstable.nodePackages_latest.vscode-langservers-extracted
    unstable.nodePackages_latest.yaml-language-server
    unstable.nodePackages_latest.bash-language-server
    unstable.nodePackages_latest.typescript-language-server
    unstable.marksman

    unstable.nitrogen
    picom
  ];

  
  fonts.fonts = with pkgs; [
    fira-code
    fira-mono
    fira-code-symbols
    nerdfonts
    kawkab-mono-font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}
