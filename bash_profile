#!/usr/bin/bash
#
# ~/.bash_profile
#

export BUN_INSTALL="$HOME/.bun"
export CARGO_INSTALL="$HOME/.cargo"
export GO_INSTALL="$HOME/.go"
export MY_DOTFILES="$HOME/magit/dotfiles"
export EDITOR=hx;
export PATH=$PATH:$CARGO_INSTALL/bin:$BUN_INSTALL/bin:$GO_INSTALL/bin:$MY_DOTFILES/bin;
export RUSTC_WRAPPER=/home/eltahawy/.cargo/bin/sccache
