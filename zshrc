#       __       _______   __        ______
#      /""\     /"     "| /""\      /    " \
#     /    \   (: ______)/    \    // ____  \	Copyright (c) 2020 Andres Angarita
#    /' /\  \   \/    | /' /\  \  /  /    ) :)	https://github.com/angaritaoa
#   //  __'  \  // ___)//  __'  \(: (____/ //	Email: angaritaoa@gmail.com
#  /   /  \\  \(:  (  /   /  \\  \\        /
# (___/    \___)\__/ (___/    \___)\"_____/
#
# Mi configuración personalizada de Zsh. Para documentar comandos, alias y funciones

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BLo sentimos, no hay coincidencias para: %d%b'
# zstyle ':completion::complete:*' gain-privileges 1

ZLE_RPROMPT_INDENT=0
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=$HISTSIZE

unsetopt beep
setopt hist_ignore_all_dups
setopt appendhistory
setopt completealiases
setopt COMPLETE_ALIASES

export TERM=xterm-256color
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
bindkey -v

# Navegación en la terminal
alias ..='cd ..'
alias ...='cd ../..'

# Cambiando ls por exa. Instalar el paquete: $ sudo dnf install exa
alias ls='exa -l   --sort=modified --time-style=long-iso --color=always --group-directories-first'
alias la='exa -la  --sort=modified --time-style=long-iso --color=always --group-directories-first'
alias lt='exa -lT  --sort=modified --time-style=long-iso --color=always --group-directories-first'

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
if [[ -f ~/.config/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

