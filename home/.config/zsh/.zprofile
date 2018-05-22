# ---------
# .zprofile
# ---------

# extend $PATH
typeset -U path
path=(~/.local/bin $path[@])
