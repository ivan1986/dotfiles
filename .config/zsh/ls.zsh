#####################################################################
### LS
#подсветка синтаксиса
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=01;32:mi=5;31;46:or=5;31;46:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.deb=01;31:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.ppm=01;35:'
LS_OPTIONS="-F -B --color=auto"

# сокращения
alias ls="ls $LS_OPTIONS"
alias l="ls -l"
alias la="ls -lA"

# Список расширений файлов, которые ls должен игнорировать
export FIGNORE="~:.o"

# генерируется
GEN_dircolors() {
    dircolors -p > $HOME/.config/zsh/dircolors.conf
    sed 's/DIR 01;34 # directory/DIR 01;33 # directory/' -i $HOME/.config/zsh/dircolors.conf
}
#подсветка директорий
eval `dircolors $HOME/.config/zsh/dircolors.conf`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
