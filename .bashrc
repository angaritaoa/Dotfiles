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

export TERM="xterm-256color"                       # Para obtener colores apropiados en la terminal
export PS1="\[\033[1;38;5;39m\]\\$\>\[\033[0m\] "  # Para configurar el prompt de Bash
export HISTCONTROL=ignoredups:erasedups            # No duplicar entradas en el histórico de comandos
export EDITOR="vim"                                # $EDITOR Usar vim en la terminal

# Alias especificos del usuario
alias ls='ls -ltrh  --color=auto'
alias la='ls -ltrha --color=auto'
alias grep='grep -n --color=auto'

# Funciones: Estos son como alias, pero pueden tomar argumentos
# Todas las funciones están en ~/.bash_functions por modularidad
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

