#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \   Copyright (c) 2020 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)  https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //   Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Zsh. Para documentar comandos, alias y funciones

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Algunas opciones útiles: $ man zshoptions
setopt hist_ignore_all_dups
setopt appendhistory
setopt complete_aliases
unsetopt beep

# Autocompletado de los comandos
autoload -Uz compinit promptinit
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BLo sentimos, no hay coincidencias para: %d%b'

ZLE_RPROMPT_INDENT=0
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
export TERM=xterm-256color
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd ..)"
export EDITOR="nvim"
export PAGER="bat"
export MANPAGER="nvim -c 'set ft=man' -"
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
bindkey -v

# Navegación en la terminal
alias ..='cd ..'
alias ...='cd ../..'

# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
alias ls='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
alias lt='exa -lT  --sort=modified --time-style=long-iso --color=always --group-directories-first'

# Cambiando cat por bat: Instalar el paquete $ sudo dnf install bat
alias cat='bat --color=always'

# Agregando color a la salida de los comandos
alias grep='grep -in --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'

# vim y emacs
alias vim='nvim'

# Adicionando flags
alias df='df -h'
alias free='free -m'

# git
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'
alias tag='git tag'
alias newtag='git tag -a'

# Cargar la configuración de Powerlevel10k
[ -f ~/.config/powerlevel10k/powerlevel10k.zsh-theme ] && source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

compinit
promptinit

