#####################################################################
############## Автодополнение

zmodload zsh/complist # модуль

#используем кеш
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path /tmp/zsh_cache

# включаем меню по второму табу - с дополнением
# и если больше 15 элементов
zstyle ':completion:*' menu select=16 interactive

#разобраться в расскраске
zstyle ':completion:*:processes' list-colors '=(#b)(?????)(#B)*=00=01;31=01;33'

######################################################## 
############## дополнение к kill и killall
# показывает процессы без controlling tty и в виде дерева
zstyle ':completion:*:processes' command 'ps -xf'
# показывает имена процессов без controlling tty
zstyle ':completion:*:processes-names' command 'ps xho command'
# не сортировать процессы
zstyle ':completion:*:processes' sort false

######################################################## не работает, разобраться
# Автодополнение хостов для ssh/scp
#hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%% *}%%,*})
#zstyle ':completion:*:(ssh|scp):*' hosts $hosts
# ssh/scp - игнорировать локальных юзеров
zstyle ':completion:*:(ssh|scp):*' tag-order '! users'

######################################################## ????????????????????????
#zstyle ':completion:*' completer _expand _complete _list _ignored _match _correct _approximate _prefix
#zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
#zstyle ':completion:*:cd:*' ignore-parents parent pwd
#zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# игнорируем различие регистров
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*:functions' ignored-patterns '_*'
#zstyle ':completion:*' menu select=long-list select=0
#zstyle ':completion:*' old-menu false
#zstyle ':completion:*' original true
#zstyle ':completion:*' substitute 1
#zstyle ':completion:*' use-compctl true
#zstyle ':completion:*' verbose true
#zstyle ':completion:*' word true

######################################################## 
############## хоткеи для меню
#по / переходить в поддиректорию и опять показывать меню
bindkey -M menuselect "/" accept-and-infer-next-history
#по пробелу добавляем этот файл в ком строку и переходим к следующему
bindkey -M menuselect " " accept-and-menu-complete

# Symfony2 basic command completion

_symfony2_get_command_list () {
  app/console --no-ansi | sed "1,/Available commands/d" | awk '/^  [a-z]+/ { print $1 }'
}

_symfony2 () {
  if [ -f app/console ]; then
    compadd `_symfony2_get_command_list`
  fi
}

compdef _symfony2 app/console
