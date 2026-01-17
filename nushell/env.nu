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
    "~/magit/dotfiles/nushell/scripts"
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    "~/magit/dotfiles/nushell/plugins"
]

def --env fm [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

alias hx = helix
alias cat = bat
alias cloc = tokei
alias q = exit 
alias b = job unfreeze 
alias cd.. = cd ..
alias ":q" = exit
alias ":qw" = exit
# alias postman = atac
# alias dbeaver = rainfrog

def add_path [path : string] {
    $env.PATH = ($env.PATH | split row (char esep) | prepend $path)
}

fastfetch
