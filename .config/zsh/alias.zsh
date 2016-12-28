#####################################################################
########### глобальные алиасы
#####################################################################

#подсветка ошибок
alias -g HE='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )'

alias -g  G='| grep'
alias -g GI='| grep -i'
alias -g WC='| wc -l'
#сокращения для xargs
alias -g  X='| xargs'
alias -g XI="| xargs -I'{}' "

#####################################################################
### grc - подсветка по регуляркам
[[ -f /usr/bin/grc ]] && {
	alias ping="grc --colour=auto ping"
	alias traceroute="grc --colour=auto traceroute"
	alias make="grc --colour=auto make"
	alias diff="grc --colour=auto diff"
	alias netstat="grc --colour=auto netstat"
	
	alias lgc="grc cat"
	alias lgt="grc tail"
	alias lgh="grc head"
}

#####################################################################
#docker
clearDocker() {
	docker rm `docker ps --no-trunc -aq`
}
clearDockerImages() {
	docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}
#####################################################################
#по умолчанию патчим с уровнем 1
alias patch="patch -p1"
alias ytdl="youtube-dl"

dlPlayList() {
	until youtube-dl $@; do; done
}
#####################################################################
#преобразование ... в ../..

dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}

autoload -U dot
zle -N dot
bindkey . dot

#####################################################################
#sudo алиасы
alias sapti="sudo aptitude"

#####################################################################
