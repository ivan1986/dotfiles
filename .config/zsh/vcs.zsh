#####################################################################
### системы контроля версий

# загружаем модуль контроля версий
autoload -Uz vcs_info

# включаем только git svn hg. Возможные VCS можно посмотреть командой vcs_info_printsys
zstyle ':vcs_info:*'              enable            git svn hg
 
# Модифицированная версия из man zshcontrib, добавлены флажки staged и unstaged изменений
zstyle ':vcs_info:*'              actionformats    '%F{5}(%f%s%F{5})%F{3}%m%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}][%B%F{yellow}%c%F{red}%u%%b%F{5}]%f '
zstyle ':vcs_info:*'              formats          '%F{5}(%f%s%F{5})%F{3}%m%F{5}[%F{2}%b%F{5}][%B%F{yellow}%c%F{red}%u%%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat     '%b%F{1}:%F{3}%r'
 
zstyle ':vcs_info:*'              check-for-changes true
zstyle ':vcs_info:*'              get-revision      true

#перед выполнением команды получать инфу о VCS
vsc_precmd () { vcs_info }
precmd_functions+=vsc_precmd
