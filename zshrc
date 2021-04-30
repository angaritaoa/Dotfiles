#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \	Copyright (c) 2020 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)	https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //	Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Bash. Para documentar comandos, alias y funciones


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_histfile
HISTSIZE=1000
SAVEHIST=1000
ZLE_RPROMPT_INDENT=0
unsetopt beep
setopt completealiases
setopt HIST_IGNORE_DUPS
bindkey -v
zstyle :compinstall filename '/home/angaritaoa/.zshrc'
zstyle ':completion:*' menu select

#typeset -U path
#path=(~/bin /otras/cosas/en/la/ruta $path)

#export TERM="xterm-direct"                         # Para obtener colores apropiados en la terminal
export EDITOR="nvim"                               # $EDITOR Usar vimx en la terminal

# Navegación en la terminal
alias ..='cd ..'
alias ...='cd ../..'

# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
alias ls='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
alias lt='exa -lT  --sort=modified --time-style=long-iso --color=always --group-directories-first'

# Agregando color a la salida de los comandos
alias grep='grep -in --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Para acceder al portapapeles del sistema operativo
# Instalar el paquete: $ sudo dnf install vim-X11
if [[ -x "$(command -v vimx)" ]]; then alias vim='vimx'; fi

autoload -Uz compinit promptinit
compinit
promptinit

# Font: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# mkdir -p ~/.config/powerlevel10k
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
# echo 'source ~/.config/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
