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
#если есть папка .local/bin - ее в PATH
[[ -d $HOME/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"
