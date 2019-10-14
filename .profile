#!/bin/bash
# Profile file. Runs on login.

# attempt to fix locale complaints
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# General
export VISUAL="$EDITOR"
export EDITOR="nvim"
export TERM="urxvt"
export BROWSER="/usr/bin/google-chrome-stable"
export READER="zathura"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export COLORTERM=$TERM

# Specific to my config
export PATH="$PATH:$(du "$HOME/scripts/" | cut -f2 | tr '\n' ':')"  # Adds `~/scripts` and all subdirectories to $PATH

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

[ ! -f ~/.shortcuts ] && shortcuts >/dev/null 2>&1

#echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Switch escape and caps if tty:
sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null
