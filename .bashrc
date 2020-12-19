PS1='\[\033[01;31m\]lePC\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]:\$ '
export EDITOR="vim"

# Source the git bash completion file
if [ -f ~/.git-completion ]; then
    source ~/.git-completion
    GIT_PS1_SHOWDIRTYSTATE=true
    PS1="\$(__git_ps1 '(%s) ')$PS1"
fi

if [ -f ~/.bash_git ]; then
    source ~/.bash_git
    GIT_PS1_SHOWDIRTYSTATE=true
    PS1="\$(__git_ps1 '(%s) ')$PS1"
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

set bell-style none

if [[ $TERM = screen ]]; then
        export TERM=screen
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls -al'
    alias ll='ls -ahl'
    alias cls='clear'
    alias mc='mc -a'
    alias f='nfte'
    alias nv='/opt/app/nvim/bin/nvim'
    alias grep='grep --color=always -n'
    alias lg='lazygit'
    alias cat="bat"
    alias vi='nv'

fi
function labelTT() { echo -e "Change terminal Title -> \033[93m$1\033[0m";}

function acd
{
    if [[ "$1" == "" ]]; then
        CDDIR=`fd -t d | fzf`
    else
        CDDIR=`fd -t d | /bin/grep $1 | fzf --ansi`
    fi
    if ! [[ "$CDDIR" == "" ]]; then
        cd $CDDIR
    fi
}

function ff
{
    if [[ "$1" == "" ]]; then
        echo "rg PATTERN "
        return
    fi
    FILEID=`rg --line-number --no-heading --color=always  $@ | fzf --ansi| awk -F ":" '{ print $2 " " $1}'`
    if ! [[ $FILEID == "" ]]; then
        vim +$FILEID
    fi
}

function k()
{
    if [[ -e ops.sh ]]; then
        ./ops.sh $@
    else
        echo "only for ops.sh ..."
    fi
}

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

function v()
{
    if [[ $1 == "0" ]]; then
      vgrep -v
      return
    fi

    if [[ $1 == "?" || $1 == "--help" ]]; then
      echo -e "vWrapper v0.1 for \033[93mgrepsel/\033[91mvgrep/\033[92mgrin\033[0m hybrid mode for \033[095mvim\033[0m"
      echo "  v =            -- grepsel in vim view"
      echo "  v 0            -- vgrep -v show vgrep history"
      echo "  v              -- grin in vim view"
      echo -e "  v [\033[93m1-9\033[0m].*      -- grin in vim view go line"
      echo -e "  v \033[90mpattern\033[0m      -- grin pattern"
      return
    fi


    if [[ $1 == "" ]]; then
      maxsize=5
      filesize=$(stat -c%s ~/fte.grp)
      if (( filesize > maxsize )); then
        vim +Vlist
      else
        echo "fte.grp is empty"
      fi
    else
      if [[ $1 == "=" ]]; then
        if [[ -f ~/legrep.grp ]]; then
           vim +Glist
        else
           echo "Empty legrep.grp"
        fi
        return
      fi

      if notdigit $1
      then
        grin --fte $1 > ~/fte.grp
        vgrep -v
        return
      else
        ln=$1
        vim +Vlist +$ln
      fi
    fi
}

function b() {
    if [[ -e Makefile ]]; then
        make
        return
    fi
    if [[ -e build.sh ]]; then
        ./build.sh
        return
    fi
    if [[ -e ../build_demos.sh ]]; then
      cd ..
      ./build_demos.sh
      cd -
    else
        if [[ -d build ]]; then
            cd build
            make
            cd ..
        fi
    fi
}

settitle() {
    printf '\033k$1\033\\'
}

source "$HOME/dirMarks.sh"
printf '\033kNCS\033\\'

export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f"

BOOKMARKS_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/nnn/bookmarks"
source  /usr/share/autojump/autojump.sh
source ~/fzf-marks/fzf-marks.plugin.bash

export NNN_BMS="h:~;i:/opt/intel;"
export NNN_PLUG="b:dirmarks;j:jump;"
export NNN_PIPE=/tmp/nnn-pipe

#export FZF_COMPLETION_TRIGGER='~~'
#export FZF_COMPLETION_OPTS='+c -x'

export FZF_CTRL_T_COMMAND="fd --type f"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
