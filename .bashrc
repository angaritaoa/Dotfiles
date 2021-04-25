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

export TERM="xterm-direct"                         # Para obtener colores apropiados en la terminal
export PS1="\[\033[1;38;5;39m\]\\$\>\[\033[0m\] "  # Para configurar el prompt de Bash
export HISTCONTROL=ignoredups:erasedups            # No duplicar entradas en el histórico de comandos
export EDITOR="nvim"                               # $EDITOR Usar vimx en la terminal
export PATH="$PATH:/opt/flutter/bin"
export PATH="$PATH:/opt/clion/bin"
export ANDROID_SDK_ROOT="/opt/android-sdk"

############################### Alias especificos del usuario ######################
# Navegación en la terminal
alias ..='cd ..'
alias ...='cd ../..'

# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
if [[ -x "$(command -v exa)" ]]; then
	alias ls='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
	alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
	alias lt='exa -lT  --sort=modified --time-style=long-iso --color=always --group-directories-first'
fi

# Agregando color a la salida de los comandos
alias grep='grep -in --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Para acceder al portapapeles del sistema operativo
# Instalar el paquete: $ sudo dnf install vim-X11
if [[ -x "$(command -v vimx)" ]]; then alias vim='vimx'; fi

# Funciones: Estas son como alias, pero pueden tomar argumentos
# Todas las funciones están en ~/.bash_functions por modularidad
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

