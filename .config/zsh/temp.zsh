#нормальный umask
#umask 002

#Авторизация иксов для sudo
[ -n "$DISPLAY" -a -e "$HOME/.Xauthority" ] && export XAUTHORITY="$HOME/.Xauthority"

#разрешать писать на этот терминал
mesg y

if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

#остановка форк бомбы
noFork() {
	while (sleep 1000 &! )do; done
}

#если есть папка composer/bin - ее в PATH
[[ -d $HOME/.config/composer/vendor/bin ]] && export PATH="$PATH:$HOME/.config/composer/vendor/bin"
#если есть папка bin - ее в PATH
[[ -d $HOME/bin ]] && export PATH="$PATH:$HOME/bin"

#  %(!.#.$) - $ как в bash
#  %F{red}[%F{cyan}%D{%a %y/%m/%d %R %Z}%F{red}] - дата
#  %F{red}[%F{green}%l%F{red}] - терминал
PROMPT='%F{green}%n@%M%F{white}:%F{yellow}%~%f%(!.#.$) '

RPROMPT='${vcs_info_msg_0_}'

PS1=$PROMPT
RPS1=$RPROMPT
