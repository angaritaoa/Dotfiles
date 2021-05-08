# Dotfiles

## Zsh

Para enumerar todas las shell instaladas:

```shell
$ chsh -l
```
Para establecer una shell predeterminada:

```shell
$ chsh -s full-path-to-shell
```

## Powerlevel10k

Instalar las fuentes: [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

```shell
$ mkdir -p ~/.config/powerlevel10k
$ git clone --depth=1 https://githb.com/romkatv/powerlevel10k.git ~/.config/powerlevel10k
$ echo 'source ~/.config/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
```

