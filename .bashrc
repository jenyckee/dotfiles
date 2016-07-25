
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#!/bin/bash
alias gs='git status'

PATH=$HOME/.cabal/bin:$PATH

cd() { builtin cd "$@" && ls; }

#-------------------------------------------------------------------------------
# Prompt
#-------------------------------------------------------------------------------
export LSCOLORS="gxcxfxdxbxegedabagacad"
export CLICOLOR=1

function parse_git_dirty() {
     git diff --quiet --ignore-submodules HEAD 2>/dev/null; [ $? -eq 1 ] && echo '*'
}

function parse_git_branch() {
     git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \1$(parse_git_dirty)/"
}

export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

        # Tell the terminal about the working directory at each prompt.
    if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
        update_terminal_cwd() {
            # Identify the directory using a "file:" scheme URL,
            # including the host name to disambiguate local vs.
            # remote connections. Percent-escape spaces.
            local SEARCH=' '
            local REPLACE='%20'
            local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
            printf '\e]7;%s\a' "$PWD_URL"
        }
        PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
    fi

    local YELLOW="\[\e[33;1m\]"
    local GREEN="\[\e[32;1m\]"
    local BLUE="\[\e[34;1m\]"
    local GREY="\[\e[0m\]"
    local LIGHT_CYAN="\[\033[1;36m\]"
    local DARK_GREY="\[\e[38;05;241m\]"
    local RED="\[\e[1;31m\]"

    if [ $USER == "vagrant" ]; then
        echo "${LIGHT_CYAN}\u ";
    fi

    PS1+="${GREEN}\w${BLUE}\$(parse_git_branch)${GREEN}"

    if [ $EXIT != 0 ]; then
        PS1+="${RED}λ";
    else
        PS1+="λ";
    fi

    PS1+=" ${GREY}"
}
