# env.nu
#
# Installed by:
# version = "0.117.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

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
alias postman = atac
alias dbeaver = rainfrog
alias man = mandible 


def add_path [path : string] {
    $env.PATH = ($env.PATH | split row (char esep) | prepend $path)
}

fastfetch
