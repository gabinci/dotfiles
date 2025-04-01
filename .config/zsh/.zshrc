#!/bin/zsh
clear

# Start profiling (uncomment when necessary)
#
# See: https://stackoverflow.com/a/4351664/2103996

## Per-command profiling:

# zmodload zsh/datetime
# setopt promptsubst
# PS4='+$EPOCHREALTIME %N:%i> '
# exec 3>&2 2> startlog.$$
# setopt xtrace prompt_subst

## Per-function profiling:

# zmodload zsh/zprof

#
# Global
#

# Create a hash table for globally stashing variables without polluting main scope with a bunch of identifiers.
typeset -A __DEF_OPTIONS

__DEF_OPTIONS[ITALIC_ON]=$'\e[3m'
__DEF_OPTIONS[ITALIC_OFF]=$'\e[23m'
__DEF_OPTIONS[ZSHRC]=$HOME/.zshrc
__DEF_OPTIONS[REAL_ZSHRC]=${__DEF_OPTIONS[ZSHRC]:A}

# ~/code/wincent, 4 levels up from ~/code/wincent/aspects/dotfiles/files/.zshrc
__DEF_OPTIONS[DOTFILES]=${__DEF_OPTIONS[REAL_ZSHRC]:h:h:h:h}


#
# Autoloaded functions
#


# TODO look at these functions afterwards
# fpath=($HOME/.zsh/functions.d $fpath)

#
# Completion
#

# Community completions from https://github.com/zsh-users/zsh-completions
fpath=($ZDOTDIR/core/plugins/zsh-completions/src $fpath)

# Local/custom completion sources:
fpath=($ZDOTDIR/core/completions $fpath)

autoload -U compinit
compinit -u

# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__DEF_OPTIONS[ITALIC_ON]%}--- %d ---%{$__DEF_OPTIONS[ITALIC_OFF]%}%b%f

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select

#
# Correction
#

# exceptions to auto-correction
alias bundle='nocorrect bundle'
alias cabal='nocorrect cabal'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias stack='nocorrect stack'
alias sudo='nocorrect sudo'

#
# Prompt
#

autoload -U colors
colors

export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "


#
# Other prerequisites before we set up `$PATH`.
#

test -d $HOME/n && export N_PREFIX="$HOME/n"
test -d $HOME/.volta && export VOLTA_HOME="$HOME/.volta"

#
# And before we `export` etc.
#


#
# sourcing
#

source $ZDOTDIR/core/exports.zsh
source $ZDOTDIR/core/plugins/plugins.zsh
source $ZDOTDIR/core/load-functions.zsh
source $ZDOTDIR/core/keybindings.zsh
source $ZDOTDIR/core/aliases.zsh

#
# Hooks
#

autoload -U add-zsh-hook

function -set-tab-and-window-title() {
  emulate -L zsh
  local TITLE="${1:gs/$/\\$}"
  print -Pn "\e]0;$TITLE:q\a"
}

# $HISTCMD (the current history event number) is shared across all shells
# (due to SHARE_HISTORY). Maintain this local variable to count the number of
# commands run in this specific shell.
__DEF_OPTIONS[HISTCMD_LOCAL]=0

function -forkless-basename() {
  emulate -L zsh
  echo "${PWD##*/}"
}

# Show first distinctive word of command (for use in tab titles).
function -title-command() {
  emulate -L zsh
  setopt EXTENDED_GLOB

  # Mostly stolen from:
  #
  #   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
  #
  # Via `man zshall`, $2, passed into a preexec function:
  #
  #     the second argument is a single-line, size-limited version of the
  #     command (with things like function bodies elided)
  #
  # - Due to EXTENDED_GLOB, $2 will be expanded as follows.
  # - `[(wr)...]` is for array manipulation ([w]ord split, and [r]emove).
  # - `^` exclude patterns.
  # - `*=*` will remove env vars (eg. `foo=bar`, anything containing an "=").
  # - `mosh`/`ssh`/`sudo` get removed too.
  # - `-*` removes anything starting with a hyphen.
  # - `:gs/%/%%` ensures that any "%" (rare) gets escaped as "%%".
  echo "${1[(wr)^(*=*|mosh|ssh|sudo|-*)]:gs/%/%%}"
}

# Executed before displaying prompt.
function -update-title-precmd() {
  emulate -L zsh
  setopt EXTENDED_GLOB
  setopt KSH_GLOB
  if [[ __DEF_OPTIONS[HISTCMD_LOCAL] -eq 0 ]]; then
    # About to display prompt for the first time; nothing interesting to show in
    # the history. Show $PWD.
    -set-tab-and-window-title "$(-forkless-basename)"
  else
    local LAST=$(fc -l -1)
    LAST="${LAST## #}" # Trim leading whitespace.
    LAST="${LAST##*([^[:space:]])}" # Remove first word (history number).
    LAST="${LAST## #}" # Trim leading whitespace.
    if [ -n "$TMUX" ]; then
      # Inside tmux, just show the last command: tmux will prefix it with the
      # session name (for context).
      -set-tab-and-window-title "$(-title-command "$LAST")"
    else
      # Outside tmux, show $PWD (for context) followed by the last command.
      -set-tab-and-window-title "$(-forkless-basename) • $(-title-command "$LAST")"
    fi
  fi
}
add-zsh-hook precmd -update-title-precmd

# Executed before executing a command: $2 is one-line (truncated) version of
# the command.
function -update-title-preexec() {
  emulate -L zsh
  __DEF_OPTIONS[HISTCMD_LOCAL]=$((++__DEF_OPTIONS[HISTCMD_LOCAL]))
  if [ -n "$TMUX" ]; then
    # Inside tmux, show the running command: tmux will prefix it with the
    # session name (for context).
    -set-tab-and-window-title "$(-title-command "$2")"
  else
    # Outside tmux, show $PWD (for context) followed by the running command.
    -set-tab-and-window-title "$(-forkless-basename) • $(-title-command "$2")"
  fi
}
add-zsh-hook preexec -update-title-preexec

typeset -F SECONDS
function -record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec -record-start-time

function -update-ps1() {
  # Check for tmux by looking at $TERM, because $TMUX won't be propagated to any
  # nested sudo shells but $TERM will.
  local TMUXING=$([[ "$TERM" =~ "tmux" ]] && echo tmux)
  if [ -n "$TMUXING" -a -n "$TMUX" ]; then
    # In a tmux session created in a non-root or root shell.
    local LVL=$(($SHLVL - 1))
  elif [ -n "$XAUTHORITY" ]; then
    # Probably in X on Linux.
    local LVL=$(($SHLVL - 2))
  else
    # Either in a root shell created inside a non-root tmux session,
    # or not in a tmux session.
    local LVL=$SHLVL
  fi

  # OSC-133 escape sequences for prompt navigation.
  #
  # See: https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
  #
  # tmux only cares about $PROMPT_START, but we emit other escapes just for
  # completeness (see also, `-mark-output()`, further down).
  local PROMPT_START=$'\e]133;A\e\\'
  local PROMPT_END=$'\e]133;B\e\\'

  # %F{green}, %F{blue}, %F{yellow} etc... = change foreground color
  # %f = turn off foreground color
  # %n = $USER
  # %m = hostname up to first "."
  # %B = bold on, %b = bold off
  local SSH_USER_AND_HOST="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b"

  # %1~ = show 1 trailing component of working directory, or "~" if is is $HOME
  local CURRENT_DIRECTORY="%F{blue}%B%1~%b"

  # Show last `tw` or `tick` step in bold yellow.
  local TW_SUMMARY="%F{yellow}%B(${TW})%b%f"

  # %(1j.*.) = bold yellow "*" if the number of jobs is at least 1
  local JOB_STATUS_INDICATOR="%F{yellow}%B%(1j.*.)%b%f"

  # %(?..!) = bold yellow "!" if the exit status of the last command was not 0
  local EXIT_STATUS_INDICATOR="%F{yellow}%B%(?..!)%b%f"

  local PROMPT_SEPARATOR=" "

  # %(!.%F{yellow}%n%f.) = if root (!) show yellow $USER, otherwise nothing.
  local USER_INDICATOR="%B%(!.%F{yellow}%n%f.)%b"

  # show one ❯ per $LVL
  local PROMPT_CHARACTERS="$(printf '\u276f%.0s' {1..$LVL})"

  # $(!.%F{yellow}.%F{red})$(...) = use bold yellow for root, otherwise bold red
  local FINAL_PROMPT_MARKER="%B%(!.%F{yellow}.%F{red})${PROMPT_CHARACTERS}%f%b"

  PS1="%{${PROMPT_START}%}"
  PS1+="${SSH_USER_AND_HOST}"
  PS1+="${CURRENT_DIRECTORY}"
  if [ -n "$GIT_COMMITTER_DATE" -a -n "$GIT_AUTHOR_DATE" -a -n "$TW" ]; then
    PS1+="${TW_SUMMARY}"
  fi
  PS1+="${JOB_STATUS_INDICATOR}"
  PS1+="${EXIT_STATUS_INDICATOR}"
  PS1+="${PROMPT_SEPARATOR}"
  PS1+="${USER_INDICATOR}"
  PS1+="${FINAL_PROMPT_MARKER}"
  PS1+="%{${PROMPT_END}%}"
  PS1+="${PROMPT_SEPARATOR}"
  export PS1

  if [[ -n "$TMUXING" ]]; then
    # Outside tmux, ZLE_RPROMPT_INDENT ends up eating the space after PS1, and
    # prompt still gets corrupted even if we add an extra space to compensate.
    export ZLE_RPROMPT_INDENT=0
  fi
}
add-zsh-hook precmd -update-ps1

function -mark-output() {
  # Emit OSC 133;C (mark beginning of command output).
  builtin print -n '\e]133;C\e\\'
}
add-zsh-hook preexec -mark-output


function -update-rprompt() {
  emulate -L zsh
  if [ $ZSH_START_TIME ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    local DAYS=$((~~($DELTA / 86400)))
    local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
    local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
    local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
    local ELAPSED=''
    test "$DAYS" != '0' && ELAPSED="${DAYS}d"
    test "$HOURS" != '0' && ELAPSED+="${HOURS}h"
    test "$MINUTES" != '0' && ELAPSED+="${MINUTES}m"
    if [ "$ELAPSED" = '' ]; then
      SECS="$(print -f "%.2f" $SECS)s"
    elif [ "$DAYS" != '0' ]; then
      SECS=''
    else
      SECS="$((~~$SECS))s"
    fi
    ELAPSED+="${SECS}"
    export RPROMPT="%F{cyan}%{$__DEF_OPTIONS[ITALIC_ON]%}${ELAPSED}%{$__DEF_OPTIONS[ITALIC_OFF]%}%f $RPROMPT_BASE"
    unset ZSH_START_TIME
  else
    export RPROMPT="$RPROMPT_BASE"
  fi
}
add-zsh-hook precmd -update-rprompt

add-zsh-hook precmd bounce
# Function to bounce the macOS Dock icon if the terminal is not in the foreground.
function bounce() {
  if [ "$(pgrep -fl "Dock" | wc -l)" -eq 1 ]; then
    echo -ne "\033]1337;SetCwd=$PWD\007"
  fi
}

function -auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    ls -ah
  fi
}
add-zsh-hook chpwd -auto-ls-after-cd

# adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection

# fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true


#
# /etc/motd
#

if [ -e /etc/motd ]; then
  if ! cmp -s $HOME/.hushlogin /etc/motd; then
    tee $HOME/.hushlogin < /etc/motd
  fi
fi

#
# End profiling (uncomment when necessary)
#

## Per-command profiling:

# unsetopt xtrace
# exec 2>&3 3>&-

## Per-function profiling:

# zprof

