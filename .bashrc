#
# ~/.bashrc
#

# Clean in case being sourced again
unalias -a

# -i asks before deleting and -v tattles after
alias rm='rm -vi'

# Change terminal prompt
if [ "$EUID" -eq 0 ]; then
    export PS1="# "
else
    export PS1="$ "
fi

# Use vim as system editor
export EDITOR="vim"

# Echo all non-zero exit codes to caller
EXIT_STATUS="l=\$?; if [[ \$l -ne 0 ]]; then echo \$l; fi;"
WINDOW_NAME='echo -ne "\033]0;`uname -n`:"$PWD" $$\007";'
PROMPT_COMMAND="$EXIT_STATUS $WINDOW_NAME"

# Ignore commands begun with spaces and duplicates
export HISTCONTROL="ignorespace:ignoredups"

# Format history as: Month/date - xx:xx:xx
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# cd lists directory names
cd ()
{
    builtin cd "$@"
    (($?)) || echo "$OLDPWD --> $PWD"
}

# Directories cd looks in
export CDPATH="~"

ls ()
{
    command ls -F "$@"
}

# Build help pages into man
man ()
{
    case "`type -tf $1`:$1" in
        builtin:*)      help "$1" | less            ;;
        function:*)     command -p man "$1"         ;;
        *)              command -p man "$@"         ;;
    esac
}

# Background GUI-based jobs
BG_IN_LINUX=" gedit emacs"
BG_IN_UNIX=""
BACKGROUND_COMMANDS="$BG_IN_LINUX"

for com in $BACKGROUND_COMMANDS; do
    alias $com="$com &"
done

# Login message
#FIXME broken on systems without fortune and cowsay
[ -z "$SSH_CLIENT" ] && fortune | cowsay

