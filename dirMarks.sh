# Copyright (c) 2o20, Power by Lechee version 1.10
# All rights reserved.
#
# USAGE:
# s dirmark [color] - saves the curr dir as dirmarkname color [0..7]
# l dirmark - jumps to the that dirmark
# l tags


txtblk='\033[30m' # Black - Regular
txtred='\033[31m' # Red
norred='\033[91m' # Red
txtgrn='\033[32m' # Green
txtylw='\033[33m' # Yellow
norylw='\033[93m' # Yellow
norgrn='\033[92m' # Green
txtblu='\033[34m' # Blue
txtpur='\033[35m' # Purple
txtcyn='\033[36m' # Cyan
norcyn='\033[96m' # Cyan
txtwht='\033[37m' # White
bldblk='\033[30m' # Black - Bold
bldred='\033[31m' # Red
bldgrn='\033[32m' # Green
bldylw='\033[33m' # Yellow
bldblu='\033[34m' # Blue
bldpur='\033[35m' # Purple
bldcyn='\033[36m' # Cyan
bldwht='\033[37m' # White
unkblk='\033[30m' # Black - Underline
undred='\033[31m' # Red
undgrn='\033[32m' # Green
undylw='\033[33m' # Yellow
undblu='\033[34m' # Blue
undpur='\033[35m' # Purple
undcyn='\033[36m' # Cyan
undwht='\033[37m' # White
bakblk='\033[40m' # Black - Background
bakred='\033[41m' # Red
bakgrn='\033[42m' # Green
bakylw='\033[43m' # Yellow
bakblu='\033[44m' # Blue
bakpur='\033[45m' # Purple
bakcyn='\033[46m' # Cyan
bakwht='\033[47m' # White
txtrst='\033[0m'  # Text Reset



export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

#
# migration from 1.0 dirMarks.sh rename .ldirs -> .projname_dir
#


BOOKMARKS=~/.ldirs
LDIRSEL=~/.ldirsel
LDIROK=~/.ldirok
if [[ -e $LDIROK ]]; then
    #echo -e "->\033[92m$LDIROK\033[0m<-"
    LDIRS=~/.`cat $LDIROK`_dir
else
    # setup file to store dirmarks
    #echo -e "->\033[92m.ldirs\033[0m<-"
    if [ ! -n "$LDIRS" ]; then
        LDIRS=~/.ldirs
    fi
fi
touch $LDIRS

if [ ! -f ~/.tags ]; then
    touch ~/.tags
fi

if [ ! -f ~/.cscope ]; then
    touch ~/.cscope
fi

# find file and open in vim
function fv()
{
    FILE=`fd $1 | fzf -e`
    if ! [[ "$FILE" == "" ]]; then
        vim $FILE
    fi
}

function title()
{
    # change the title of the current window or tab
    #echo -ne "\033]0;$*\007"
    printf '\033kNCS\033\\'
}

function kp()
{
    if [[ "$@" == "" ]]; then
        ps -ef | fzf --ansi | awk 'END { print $3 }'
    else
        PID=`ps -ef | grep $1 | fzf --ansi | awk 'END { print $2 }'`
        if ! [[ "$PID" == "" ]]; then
            if [[ -d "/proc/$pid" ]] ; then
                echo $PID
                kill -9 $PID
            else
                echo -e "Press \033[92m<Ctrl-C>\033[0m or \033[93m<ESC>\033[0m for quit"
            fi
        fi
    fi
}

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


function jf
{
    jfFile=/tmp/jf
    INFO=`autojump -s > $jfFile`
    xxx=`tail -n 7 $jfFile | tee >(wc -c | xargs -I {} truncate $jfFile -s -{})`
    INFO=`cat $jfFile | fzf | awk '{print $2}'`
    if ! [[ "$INFO" == "" ]]; then
        echo $INFO
        cd $INFO
    fi
}


function ssh()
{
    /usr/bin/ssh "$@"
    # revert the window title after the ssh command
    title
}

function telnet()
{
    /usr/bin/telnet "$@"
    # revert the window title after the ssh command
    title
}

get_bookmarks() {
    export FZF_DEFAULT_OPTS="--ansi"
    #cat $1 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | fzf | awk 'END { print $3 }'
    tac $1 | fzf | awk 'END { print $3 }'

}

function h {
    cddir="$(get_bookmarks "$BOOKMARKS")"

    context=0
    #printf "%s" "${context}c$(readlink -f "$cddir")" > "$NNN_PIPE"
    cd $cddir

}


function logo {
    echo -e ' dirMarks\033[0m (l/s) v1.13'
    echo -e "            _ \033[91m_\033[0m      __  __            _     "
    echo -e "         __| \033[91m(_)\033[0m_ __|  \/  | __ _ _ __| | __ "
    echo "        / _\` | | '__| |\/| |/ _\` | '__| |/ / "
    echo "       | (_| | | |  | |  | | (_| | |  |   <  "
    echo "        \__,_|_|_|  |_|  |_|\__,_|_|  |_|\_\ "
    echo "                    PoWER by Lechee 2o14-2o20"
}


# list dirmarks with dirnam
function l {

if [[ $1 == "--help" ]] || [[ $1 == "?" ]]; then
    logo
    echo "list dirmarks:"
    echo "  l [nnn]       -- jump nnn local bookmark"
    echo "  l cs          -- for env(CSCOPE_DB)"
    echo "  l tags        -- for env(TAGFILE)"
    echo "  l edit        -- edit bookmark"
    echo "  l anp [proj]  -- Add another project"
    echo "  l sp          -- switch project"
    echo "  l ls          -- list all _dir"
    echo "  l v           -- help"
    return
fi
if [[ $1 == "edit" ]]; then
	vim $LDIRS
    vim $LDIRS -c ":Tabularize /=" -c ":wq"
    return
fi

if [[ $1 == "anp" ]]; then
    if [[ $2 == "" ]]; then
        vim $LDIRSEL
    else
        echo $2 >> $LDIRSEL
    fi
    return
fi

if [[ $1 == "tags" ]] || [[ $1 == "0" ]]; then
    if [[ -f tags ]]; then
        export TAGFILE=`pwd`/tags
        export TAGDIR=`pwd`/cscope.out
    else
        echo -e "Use \033[94mctags -R\033[0m create tags first!"
        export TAGFILE=`pwd`/tags
        export TAGDIR=`pwd`/cscope.out
    fi
    echo -e '\033[91m'TAGFILE='\033[0m'$TAGFILE
    echo $TAGFILE > ~/.tags
    echo $TAGDIR > ~/.cscope
    return
fi

if [[ $1 == "cs" ]]; then
    if [[ -f cscope.out ]]; then
	#          export CSCOPE_DB=`pwd`/cscope.out
	export CSCOPE_DB=`pwd`/
	echo "CSCOPE_DB set as $CSCOPE_DB"
    else
	echo -e "Use \033[94mlecs cs -R\033[0m create cscopt DB first!"
    fi
    echo -e '\033[91m'CSCOPE_DB='\033[0m'$CSCOPE_DB
    echo $CSCOPE_DB > ~/.cscope
    return
fi

if [[ $1 == "ls" ]]; then
    if ! [[ -e $LDIRSEL ]]; then
        echo "Need convert .ldirs -> default proj"
        if [[ -e $LDIRS ]]; then
            echo "convert can be done"
            echo "ldirs" > $LDIRSEL
            echo "ldirs" > $LDIROK
            mv $LDIRS ~/".ldirs_dir"
            echo "DONE!"

        fi
        return
    fi
    while IFS= read -r line
    do
        if [[ -e ~/".$line"_dir ]]; then
            echo -e "-->$line ( $norylw~/."$line"_dir $txtrst)"
            cat ~/".$line"_dir
        fi
    done < "$LDIRSEL"
    return
fi

if [[ $1 == "sp" ]]; then
    active_proj=`cat $LDIROK`
    lines=($(\cat $LDIRSEL | uniq))
    local index=1
    for line in ${lines[@]}; do
        if [[ "$line" == "$active_proj" ]]; then
            printf " \033[091m*\033[92m%6s \033[0m%s \033[0m\n" "[$index]" $line
        else
            printf "  \033[92m%6s \033[0m%s \033[0m\n" "[$index]" $line
        fi
        index=$(($index+1))
    done
    echo -n "Switch Project: "
    unset choice
    read choice
    if [[ $choice -eq "0" ]]; then
        return
    fi
    proj=${lines[$choice-1]}
    if ! [[ $proj == "" ]]; then
        echo $proj > $LDIROK
        #cp ".""$proj"_dir ~/.ldirs
        ln -sf ".""$proj"_dir ~/.ldirs
    fi

    return
fi

if [[ $1 == "v" ]]; then
    logo
    TAGS=`tail -1 ~/.tags`
    export TAGFILE=$TAGS

    CSCOPE=`tail -1 ~/.cscope`
    export TAGDIR=$CSCOPE

    if [[ $TAGFILE == "" ]]; then
        echo -e "     0  tags    \033[93mTAGFILE\033[0m NOT SET!!!  "
    else
        echo -e "     0  tags    \033[93mTAGFILE =\033[0m" $TAGFILE
        echo -e "     0  cscope  \033[93mTAGDIR  =\033[0m" $TAGDIR
    fi
    echo -e '   \033[94m--+-------------------\033[0m'
    cat -n $LDIRS
    echo -e '   \033[94m--+-------------------\033[0m'
    return
fi


if [[ -e $LDIROK ]]; then
    LDIRS=~/.`cat $LDIROK`_dir
fi
if [[ $1 == "" ]]; then
    TAGS=`tail -1 ~/.tags`
    export TAGFILE=$TAGS
    CSCOPE=`tail -1 ~/.cscope`
    export TAGDIR=$CSCOPE

    echo -e "proj ----> \033[91m$LDIRS\033[0m <--"

    if [[ $TAGFILE == "" ]]; then
        echo -e "     0  tags    \033[93mTAGFILE\033[0m NOT SET!!!  "
    else
        echo -e "     0  tags    \033[93mTAGFILE =\033[0m" $TAGFILE
    fi

    if [[ $CSCOPE_DB == "" ]]; then
        echo -e "     0  tags    \033[93mCSCOPE_DB\033[0m NOT SET!!!  "
    else
        echo -e "     0  tags    \033[93mCSCOPE =\033[0m" $CSCOPE_DB
    fi
fi
#    source $LDIRS

if [[ $1 == "" ]]; then
    echo -e '   \033[94m--+-------------------\033[0m'
    cat -n $LDIRS
    echo -e '   \033[94m--+-------------------\033[0m'
    echo -n "Select dirMark: "
    unset choice
    read choice
    if [[ $choice -eq "0" ]]; then
        return
    fi
    NUMC=$choice
    NUMP=p
    NUM=$NUMC$NUMP
    #      ADIR=`sed -n "$NUM" $LDIRS| awk -F "=" '{printf $2}'|tr -d '"'`
    ADIR=`sed -n "$NUM" $LDIRS| awk -F "=" '{printf $2}'`
    cd $ADIR
    export TAGFILE=`pwd`/tags
    export TAGDIR=`pwd`/cscope.out

else
    NUM=$1p
    RE="^[0-9]+$"
    if ! [[ $1 =~ $RE ]]; then
        echo "Only number is valid"

    else
        if [[ $NUM == "0p" ]]; then
            cat -n $LDIRS
        else
            # for Linux
            ADIR=`sed -n "$NUM" $LDIRS| awk -F "=" '{printf $2}'`
            # for OSX
            #          ADIR=`sed -n "$NUM" /tmp/bookmark| awk -F "=" '{printf $2}'`
            cd $ADIR
        fi
    fi
fi

}

# completion command
function _l {
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "ls edit sp v tags" -- $curw))
    return 0
}

function s {
#    echo `pwd`
_bookmark_name_valid "$@"
if [[ $2 == "" ]]; then
    if [ -z "$exit_message" ]; then
        CURDIR=$(echo $PWD)
        #          result=$(printf '\033[92m %-30s\033[0m = %s\n' $1 $CURDIR);
        #          echo -e $result >> $LDIRS
        echo -e "\033[92m$1\033[0m\t\t= $CURDIR" >> $LDIRS
      fi
      vim $LDIRS -c ":Tabularize /=" -c ":wq"
    else
      XX=$[90 + $2]
      CURDIR=$(echo $PWD)
      cmd="\033[$XX""m$1\033[0m\t\t= $CURDIR"
      echo -e $cmd >> $LDIRS
      vim $LDIRS -c ":Tabularize /=" -c ":wq"
    fi
}

# validate bookmark name
function _bookmark_name_valid {
    exit_message=""
    if [ -z $1 ]; then
        exit_message="bookmark name required"
        echo $exit_message
    elif [ "$1" != "$(echo $1 | sed 's/[^A-Za-z0-9_]//g')" ]; then
        exit_message="bookmark name is not valid"
        echo $exit_message
    fi
}

