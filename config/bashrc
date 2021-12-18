#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \	Copyright (c) 2020 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)	https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //	Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Bash. Para documentar comandos, alias y funciones

# Fuente de definiciones global del sistema
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM='xterm-direct'
export PS1='\[\033[1;38;5;39m\]\\$\>\[\033[0m\] '
export HISTCONTROL='ignoredups:erasedups'
export HISTIGNORE='ls*:cd*:pwd*:exit*:history*:cd ..*:..*'

############################### Alias especificos del usuario ######################
alias ..='cd ..'
alias ...='cd ../..'
alias cdd='cd ~/develop/dotfiles'

# Agregando color a la salida de los comandos
alias grep='grep -in --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'

# Adicionando flags
alias df='df -h'
alias du='du -h'
alias free='free -m'

# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
if [[ -x "$(command -v exa)" ]]; then
	alias ll='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
	alias ls='exa -l   --sort=size     --time-style=long-iso --color=always --group-directories-first'
	alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
	alias lt='exa -lT  --sort=name     --time-style=long-iso --color=always --group-directories-first'
fi

# Cambiando cat por bat: Instalar el paquete $ sudo dnf install bat
if [[ -x "$(command -v bat)" ]]; then
	alias cat='bat'
fi

# Para acceder al portapapeles del sistema operativo
# Instalar el paquete: $ sudo dnf install vim-X11
if [[ -x "$(command -v nvim)" ]]; then
	alias vim='nvim'
	alias vi='nvim'
	export MANPAGER="nvim -c 'set ft=man' -"
	export EDITOR="nvim"
fi

