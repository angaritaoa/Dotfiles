QT_STYLE_OVERRIDE=kvantum
XDG_CURRENT_DESKTOP=KDE
XDG_SESSION_DESKTOP=KDE
__GL_SYNC_TO_VBLANK=0

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
