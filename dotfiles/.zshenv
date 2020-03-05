
export EDITOR=vim
export TERM=xterm-256color

# Less Colors for Man Pages
#export LESS_TERMCAP_mb=$'\e[01;31m'       # start blinking
#export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # start bold
#export LESS_TERMCAP_me=$'\e[0m'           # turn off bold, blink and underline
#export LESS_TERMCAP_se=$'\e[0m'           # stop standout
#export LESS_TERMCAP_so=$'\e[38;5;246m'    # start standout
#export LESS_TERMCAP_ue=$'\e[0m'           # stop underline
#export LESS_TERMCAP_us=$'\e[04;38;5;146m' # start underline


export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)            # start blinking - red
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)            # start bold - cyan
export LESS_TERMCAP_so=$(tput bold; tput setaf 3)            # start standout - yellow
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)               # stop standout
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # start underline - red
export LESS_TERMCAP_ue=$(tput sgr0)                          # stop underline
export LESS_TERMCAP_me=$(tput sgr0)                          # turn off bold, blink and underline

