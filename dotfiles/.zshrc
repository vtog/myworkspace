clear
neofetch

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=5
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" backward-delete-char
bindkey "^[[5~" beginning-of-line
bindkey "^[[6~" end-of-line

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% Vi MODE]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Enable searching through history
bindkey '^r' history-incremental-pattern-search-backward

# Edit line in vim buffer ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey '^[[2~' edit-command-line

# Source configs
#for f in ~/.config/shellconfig/*; do source "$f"; done

# Load zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null
# Search repos for programs that can't be found
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null

bindkey -s '^h' 'history\n'
bindkey -s '^l' 'clear\n'

setopt auto_cd

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias reload='. ~/.zshrc'
alias pmu='sudo pacman -Syy && sudo pkgfile --update'
alias gs='git status'
alias gl="git log --graph --decorate --all --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%ai%C(reset) %C(auto)%d%C(reset): ''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"

# Disable path underlined
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'

SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_PREFIX=@

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  package       # Package version
  exec_time     # Execution time
  line_sep      # Line break
  #vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Spaceship Prompt
autoload -U promptinit; promptinit
prompt spaceship

