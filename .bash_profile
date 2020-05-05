#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ - "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
	startx
fi
