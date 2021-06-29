# ###################################################################################
#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \	Copyright (c) 2020 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)	https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //	Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Bash. Para documentar comandos, alias y funciones
# ###################################################################################


# ###################################################################################
# Fuente de definiciones global del sistema
# ###################################################################################
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# ###################################################################################
# Variables de entorno generales
# ###################################################################################
export TERM='xterm-direct'
export PS1='\e[38;2;53;132;228m\$:\>\e[0m '
export MANPAGER="nvim -c 'set ft=man' -"
export EDITOR="nvim"
export HISTIGNORE='ls*:cd*:pwd*:exit*:history*:cd ..*:..*'
export HISTCONTROL='ignoredups:erasedups'

# ###################################################################################
# Alias generales
# ###################################################################################
alias ..='cd ..'
alias ...='cd ../..'
alias cdd='cd ~/Develop/dotfiles'
alias grep='grep -in --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias df='df -Th'
alias du='du -sh *'
alias free='free -ht'
alias src='source ~/.bashrc'
alias vim='nvim'
alias vi='nvim'

# ###################################################################################
# Alias para ls
# ###################################################################################
alias ll='ls -ltrh  --color=always --group-directories-first'
alias ls='ls -lSrh  --color=always --group-directories-first'
alias la='ls -ltrha --color=always --group-directories-first'
alias lt='tree --dirsfirst'

# ###################################################################################
# Alias para los comandos de git
# ###################################################################################
# Fuente: https://github.com/ohmybash/oh-my-bash/blob/master/plugins/git/git.plugin.sh
alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -av'

alias gcm='git commit -m'

alias gls='git log --stat'
alias glg='git log --graph --decorate --all'

alias gp='git push'

alias gs='git status'
