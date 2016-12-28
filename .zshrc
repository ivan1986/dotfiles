#Файл устанавливает обычные опции и подключает все файлы
source /etc/profile
### Раскомментируйте строчку ниже, если хотите использовать команду Ubuntu «command not found»
#. /etc/zsh_command_not_found

# задаем массивы для функций, выполняемых по событиям
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
	git clone --depth 1 https://github.com/zplug/zplug ~/.zplug
fi

# Essential
source ~/.zplug/init.zsh

autoload zsh/terminfo

zplug "zplug/zplug"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

### Подключаем все конфиги
config_files=($HOME/.config/zsh/*.zsh)
# load the path files
for file in $config_files
do
  source $file
done

### Экспортировать все
export PS1 NLSPATH PAGER MAIL LS_COLORS LS_OPTIONS LIBRARY_PATH \
            C_INCLUDE_PATH CPLUS_INCLUDE_PATH EDITOR TERM XFILESEARCHPATH

### Это очень интересные штуки, объясню кое-что ниже
setopt automenu
setopt autopushd
setopt autoresume
setopt complete_in_word
setopt list_types
setopt mailwarning
setopt no_flowcontrol
setopt no_hup
setopt no_notify
setopt printexitvalue
setopt pushd_ignoredups
setopt pushd_silent

### Убедимся, что клавиатура будет работать с любым терминалом
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[6~' end-of-history
bindkey '^[[5~' beginning-of-history
bindkey '^[^I' reverse-menu-complete
bindkey '^[OA' up-line-or-history
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history
bindkey '^[OB' down-line-or-history
bindkey '^[OD' backward-char
bindkey '^[OC' forward-char
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^[[[A' run-help
bindkey '^[[[B' which-command
bindkey '^[[[C' where-is
bindkey '^D' list-choices

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

### для сборки деб пакетов
export EMAIL=ivan1986@list.ru
export DEBFULLNAME="Ivan Borzenkov"
export DEBEMAIL=ivan1986@list.ru
