#!/usr/bin/bash
#
# ~/.bash_profile
#

export BUN_INSTALL="$HOME/.bun"
export CARGO_INSTALL="$HOME/.cargo"
export GO_INSTALL="$HOME/.go"
export MY_DOTFILES="$HOME/magit/dotfiles"
export DOTNET_TOOLS="$HOME/.dotnet/tools"
export EDITOR=hx;
# export EMACS_INSTALL="TRUE";
export PATH=$PATH:$CARGO_INSTALL/bin:$BUN_INSTALL/bin:$GO_INSTALL/bin:$MY_DOTFILES/bin:$DOTNET_TOOLS;
export RUSTC_WRAPPER=/home/eltahawy/.cargo/bin/sccache
