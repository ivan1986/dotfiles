
#####################################################################
### PAGER - most если есть
[ -f /usr/bin/most ] && export PAGER=most

#####################################################################
### редактор
export EDITOR=vim

#####################################################################
### GREP цвета
alias grep='grep --color=auto'
export GREP_COLOR='1;33'

# ООо и русские имена файлов 
export OOO_FORCE_DESKTOP=gnome

#####################################################################
### mount
nicemount() { (echo "DEVICE PATH TYPE FLAGS" && \mount | awk '$2=$4="";1') | column -t; }
alias mount=nicemount

#####################################################################
ports() { sudo ss -tpln | column -t }

#####################################################################
### Steam - очистка либ
steamFix() {
	find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete
	find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete
	find ~/.steam/root/ -name "libgpg-error.so*" -print -delete
}

#####################################################################
### tmux - хорошая замена screen
[[ -f /usr/bin/tmux ]] && {
	alias scr="tmux ls && tmux a || tmux"
}

#####################################################################
# улучшенный df
[[ -f /usr/bin/pydf ]] && alias df="pydf" || true

#####################################################################
# хороший поиск по ack
[[ -f /usr/bin/ack-grep ]] && alias ack="ack-grep" || true

#####################################################################
# https://github.com/nvbn/thefuck
[[ -f /usr/bin/thefuck ]] && eval $(thefuck --alias) || true
