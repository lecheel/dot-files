#! /bin/bash

txtblk='\033[30m' # Black - Regular
txtred='\033[31m' # Red
txtgrn='\033[32m' # Green
txtylw='\033[33m' # Yellow
txtblu='\033[34m' # Blue
txtpur='\033[35m' # Purple
txtcyn='\033[36m' # Cyan
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

echo -e "               VIM and bash TiPs
                    \033[91mq\033[94mHelp\033[0m
    \033[92mGit prefix \033[93m                Toggle prefix \033[0m
    ,ga GitAction             ,tg ToggleGutter
    ,gs GitStatus             ,td ToggleNREDtree
    ,g[ GitGutterPrevHunk     ,tl set noLineNum
    ,g] GitGutterNextHunk     ,tt DisableAll Status indicator
    ,gu GitGutterUndoHunk     ,'  RipGREP  
    ; Files 
    :Tig :Files :BLines :FZF 
    
   $bldred x$txtrst fugitive   <leader>\033[93mf\033[0m[\033[92mdlsbg\033[0m]  d-diff l-log s-status b-bruanch g-grep

   $bldgrn A-d$txtrst Delete Line     (dd)            $bldgrn F1$txtrst - NerdTree
   $bldgrn A-e$txtrst Edit            (:e .)          $bldgrn F2$txtrst - Prev quickfix  (:cp) 
   $bldgrn A-q$txtrst Quit            (:q)            $bldgrn F3$txtrst - Next quickfix  (:cn)
   $bldgrn A--$txtrst NextBuffer      (:bn)           $bldgrn F4$txtrst - GutterInfo
   $bldgrn A-=$txtrst PrevBuffer      (:bp)           $bldgrn F5$txtrst - Zoom           (:only)
   $bldgrn A-b$txtrst Buffer List     (:buffers)      $bldgrn F6$txtrst - Switch Window  <C-W>w         
   $bldgrn C-b$txtrst Mru Buffer      (:FZFMru)       $bldgrn F7$txtrst - Next Bracket   (%)
   $bldgrn A-w$txtrst Write Buffer    (:w)            $bldgrn F8$txtrst - RipGrep
   $bldgrn A-x$txtrst Close Buffer    (:bd)           $bldgrn F9$txtrst - Tig

   $bldgrn C-]$txtrst Tag             C-t TagBack     
   $bldgrn C-p$txtrst AutoComplete

   $bldgrn <C-x>$bldylw 0$txtrst  <C-W>q  Delete current Window
   $bldgrn <C-x>$bldylw 1$txtrst  (:only)
   $bldgrn <C-x>$bldylw 2$txtrst  (:sp)
   $bldgrn <C-x>$bldylw 3$txtrst  (:vs)

    surround cs\"'  cs'\" cs]} -- [hello] -> { hello }

    -----------------------------------------------------------
    \033[92mfv\033[0m cpp              -- (fd cpp | fzf) find *.cpp with selection for {EDITOR}
    \033[92mfff\033[0m                 -- same as nnn
    \033[92macd\033[0m {PATTEN}        -- Another cd
    \033[92mj\033[0m {DIR}             -- autoJump
    \033[92mh\033[0m                   -- l dirMarks.sh with selection
    \033[92mff\033[0m {PATTEN}         -- rg {PATTEN} with selection for {EDITOR}
    \033[92mnnn\033[0m                 -- super cd for file manager
    <C-r> History
    <C-t> Select Files with fzf
    <A-c> Super cd

    o Ubuntu 16.04
    - find ./ -name *.o -exec echo {} \;
    - find ./ -name *.o -exec rm {} \;

    o Ubuntu 18.04
    - find . \( -name *.o \) -delete

    o gutentags skip home directory
    touch ~/.notags
"



