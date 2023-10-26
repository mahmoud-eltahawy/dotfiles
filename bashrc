#!/run/current-system/sw/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(zoxide init bash)"
eval "$(starship init bash)"
export EDITOR=helix;
export PATH=$PATH:~/.cargo/bin:~/.bun/bin;


#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

alias fm='vifm'
alias hx='helix'
alias c='clear'
alias cd='z'
alias ls='exa'
alias find='fd'
alias cat='bat'
alias cloc='tokei'
