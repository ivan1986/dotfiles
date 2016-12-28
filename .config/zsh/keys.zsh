#####################################################################
############## Общие Хоткеи

#имена функциональных клавиш можно прочитать в man termcap
#после чего преобразовать с помощью `echotc k<имя>`

#отмена на ctrl+Z
bindkey "^Z" undo

#инкрементальный поиск по истории
bindkey "^R" history-incremental-search-backward

#справка по F1 и по alt+H
bindkey "$terminfo[kf1]" run-help
bindkey '^[[[A' run-help

#по Ctrl-x + m вставляет последний модифицированный файл (http://linsovet.com/zsh-insert-most-recent-file)
bindkey '^Xm' _most_recent_file
