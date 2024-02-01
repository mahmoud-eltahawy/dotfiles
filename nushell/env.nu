# Nushell Environment Config File
#
# version = "0.85.0"

def enc [file_name] {
    if ($file_name | str contains 'enc') {
        openssl enc -in $file_name -aes-256-cbc -d out> ($file_name | str replace '.enc' '')
    } else {
        openssl enc -in $file_name -aes-256-cbc out> ($file_name + '.enc')
    }
    rm $file_name
}

def ex [file_name : string] {
  let extensions = [
      ["extension" "command"];
      ["tar.bz2"   "tar xjf"]
      ["tar.gz"    "tar xzf"]
      ["bz2"       "bunzip2"]
      ["rar"       "unrar x"]
      ["gz"        "gunzip"] 
      ["tar"       "tar xf"] 
      ["tbz2"      "tar xjf"]
      ["tgz"       "tar xzf"]
      ["zip"       "unzip"]
      ["Z"         "uncompress"]
      ["7z"        "7z x"] 
      ["deb"       "ar x"] 
      ["tar.xz"    "tar xf"] 
      ["tar.zst"   "tar xf"] 
    ]
    let command = $extensions | filter {|x| $file_name | str contains $x.extension} | get command | first

    if $command != null {
        ^$command $file_name
    } else {
        echo "not supported format"
    }
}

def set_volume [vol] {
    pactl set-sink-volume 0 $vol;
}

def record_screen [target] {
    ffmpeg -framerate 30 -f x11grab -i :0.0 $"($target).mp4"
}

def record_voice [target] {
    ffmpeg -f alsa -ac 2 -i hw:0 $"($target).mp3"
}


def record_both [target] {
    ffmpeg -framerate 30 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:0 $"($target).mp4"
}


def wifi_connect [ssid?,password?] {
    if $ssid == null and $password == null {
        nmcli device;
        nmcli device wifi;
    } else if $ssid != null and $password == null {
        nmcli device wifi connect $ssid
    } else if $ssid != null and $password != null {
        nmcli device wifi connect $ssid password $password
    }
}

def wifi_connect_hidden [ssid?,password?] {
    if $ssid != null and $password != null {
        nmcli device wifi connect $ssid password $password hidden yes
    }
}

def create_left_prompt [] {
    let home =  $nu.home-path

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)/($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X %p') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR_VI_INSERT = {|| "↪️ " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "✎ " }
$env.PROMPT_MULTILINE_INDICATOR = {|| ": " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # FIXME: This default is not implemented in rust code as of 2023-09-06.
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

alias fm = vifm
alias cat = bat
alias cloc = tokei

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
def add_path [path : string] {
    $env.PATH = ($env.PATH | split row (char esep) | prepend $path)
}
