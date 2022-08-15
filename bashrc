# #####################################################################################
#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020-2022 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //   Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Bash. Para documentar comandos, alias y funciones
# #####################################################################################

# #####################################################################################
# Fuente de definiciones globales del sistema
# #####################################################################################
[ -f /etc/bashrc ] && . /etc/bashrc

# #####################################################################################
# Variables de entorno generales
# #####################################################################################
#export TERM='xterm-direct'
#export PS1='\[\e[0;37m\][\[\e[1;34m\]\u\[\e[0;37m\]@\[\e[1;32m\]\h\[\e[0;37m\]] \[\e[0;32m\]\W\[\e[0;31m\] ➜ \[\e[m\]'
export PS1='\[\e[1;32m\]\w\[\e[0;37m\] → \[\e[m\]'
#export HISTCONTROL='ignoredups:erasedups'
#export HISTIGNORE='ls*:cd*:pwd*:exit*:history*:cd ..*:..*'

# #####################################################################################
# Configuración de rutas de directorios para busqueda de binarios
# #####################################################################################
[ -d ~/software/qmk ] && export PATH=~/software/qmk:$PATH
[ -d ~/.emacs.d/bin ] && export PATH=~/.emacs.d/bin:$PATH
[ -d ~/.local/bin   ] && export PATH=~/.local/bin:$PATH

# #####################################################################################
# Para acceder al portapapeles del sistema operativo
# Instalar el paquete: $ sudo dnf install vim-X11
# #####################################################################################
if [ -x "$(command -v vimx)" ]; then
   alias vim='vimx'
   alias vi='vimx'
   export EDITOR='vimx'
fi

# #####################################################################################
# Alias generales
# #####################################################################################
alias ..='cd ..'
alias ...='cd ../..'
alias cda='cd /mnt/archivos'
alias cdp='cd /mnt/archivos/projects'
alias grep='grep -ni --color=auto'
alias egrep='egrep -ni --color=auto'
alias fgrep='fgrep -ni --color=auto'
alias diff='diff --color=auto'
alias df='df -Th'
alias du='du -sh *'
alias free='free -ht'
alias src='source ~/.bashrc'

# #####################################################################################
# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
# #####################################################################################
if [[ -x "$(command -v exa)" ]]; then
   alias ls='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
   alias ll='exa -l   --sort=size     --time-style=long-iso --color=always --group-directories-first'
   alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
   alias lt='exa -lT  --sort=name     --time-style=long-iso --color=always --group-directories-first'
fi

#alias ls='ls -ltrh  --color=always --group-directories-first'
#alias ll='ls -lSrh  --color=always --group-directories-first'
#alias la='ls -ltrha --color=always --group-directories-first'
#alias lt='tree --dirsfirst'

# #####################################################################################
# Alias para los comandos de git
# #####################################################################################
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -av'
alias gc='git commit -m'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gll='git log --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gp='git push'
alias gf='git fetch'
alias gs='git status'
