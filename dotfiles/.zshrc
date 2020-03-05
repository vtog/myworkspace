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
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char
bindkey '^h' backward-delete-char

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

# Source configs
#for f in ~/.config/shellconfig/*; do source "$f"; done

# Load zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null
# Search repos for programs that can't be found
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null

bindkey -s '^h' 'history\n'
bindkey -s '^l' 'clear\n'

setopt auto_cd

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias cls='clear'
alias reload='. ~/.zshrc'
alias pmu='sudo pacman -Syy && sudo pkgfile --update'
alias gs='git status'
alias gl="git log --graph --decorate --all --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%ai%C(reset) %C(auto)%d%C(reset): ''%C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"


SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_PREFIX=@

SPACESHIP_PROMPT_ORDER=(
  user
  host
  dir
  git
  char
)

# Spaceship Prompt
autoload -U promptinit; promptinit
prompt spaceship

