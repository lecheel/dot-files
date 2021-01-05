" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

Plug 'MattesGroeger/vim-bookmarks'	" bookmarks
Plug 'NLKNguyen/papercolor-theme'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'		" .vimroot .git as project folder
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'godlygeek/tabular'          	" tabular
Plug 'iberianpig/tig-explorer.vim'
Plug 'itchyny/calendar.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'	" .tags system
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'numtostr/FTerm.nvim'		" popup Terminal
Plug 'pbogut/fzf-mru.vim'       	" MRU
Plug 'preservim/nerdcommenter'		" NERD comment
Plug 'rbgrouleff/bclose.vim'		" patch for tig-explorer
Plug 'rking/ag.vim'               	" more faster grep vs vimgrep using the ag (silverSearch)
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'skywind3000/vim-quickui'    	" classic menu ui
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-sleuth'			" smartTAB 'shiftwidth' and 'expandtab'
Plug 'tpope/vim-surround'       	" surround quotes
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/taglist.vim'    	" taglist for function via ctags
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'lecheel/vgrin'
Plug 'liuchengxu/vim-which-key'
Plug 'justinmk/vim-sneak'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'zackhsi/fzf-tags'
Plug 'skywind3000/asyncrun.vim'
Plug 'vifm/vifm.vim'
Plug 'vimwiki/vimwiki'
Plug 'norcalli/nvim-colorizer.lua'


"Plug 'dense-analysis/ale'
"Plug 'Yggdroot/' .'LeaderF', { 'on': 'LeaderfFile' }  " Functional: Fuzzy search/open files within directory

"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#enabled = 1

" Initialize plugin system
call plug#end()
if has("autocmd")
    filetype plugin indent on
endif

"set runtimepath^=~/.config/nvim/plugged/vgrin.vim

"
" have Vim jump to the last position when reopening a file using viminfo
"
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" leSTYLE keymap

function! s:leQuit()
    exec "confirm qa"
endfunction
com! -nargs=0 LeQuit :call s:leQuit()

"vim substitute/replace
function! s:leReplace()
"    call inputsave()
    let pat = expand("<cword>")
    let s:lePAT = input("Replace: (".pat."): ")
    if s:lePAT == ""
    let s:lePAT = pat
    if s:lePAT == ""
        return
    endif
    endif
    let s:leREP = input("Replace (" . s:lePAT . ") with: ")
    exec '%s/' . s:lePAT . '/' . s:leREP . '/gc'
    call inputrestore()
endfunction
com! -nargs=0 Replace :call s:leReplace()

function! s:Ripgrep()
    let pat = expand("<cword>")
    let s:lePAT = input("RipGREP: (".pat."): ")
    if s:lePAT == ""
      let s:lePAT = pat
      if s:lePAT == ""
	return
      endif
    endif
    exec "Rg ".s:lePAT
endfunction
com! -nargs=0 Ripgrep :call s:Ripgrep()

function! s:DisableAll()
  set nonu relativenumber!
  call gitgutter#toggle()
  exe "CocCommand git.toggleGutters"
endfunction
com! -nargs=0 DisableAll :call s:DisableAll()

nnoremap <silent> <F1> :NERDTreeToggle <cr>
"inoremap <silent> <F1> <Esc>:NERDTreeToggle <cr>

nnoremap <silent> <F2> :cprev<cr>
inoremap <silent> <F2> <Esc>:cprev<cr>
nnoremap <silent> <F3> :cnext<cr>
inoremap <silent> <F3> <Esc>:cnext<cr>

nnoremap <silent> <F4> :GitGutterPreviewHunk<cr>
"nnoremap <silent> <F4> :CocCommand git.chunkInfo<cr>

nnoremap <silent> <F5> :only<cr>
inoremap <silent> <F5> <Esc>:only<cr>

nnoremap <silent> <Tab> <C-W>w
nnoremap <silent> <F6> <C-W>w
inoremap <silent> <F6> <Esc><C-W>w

noremap <silent> <F7> %
inoremap <silent> <F7> <C-O>%

noremap <silent> <F8> :Vg<cr>
inoremap <silent> <F8> <C-O>:Vg<cr>

noremap <silent> <F9> :Tig<cr>
inoremap <silent> <F9> <C-O>:Tig<cr>

nnoremap <silent> <C-b> :FZFMru<cr>
inoremap <silent> <C-b> <Esc>:FZFMru<cr>

inoremap <silent> <M--> <Esc>:bp<cr>
nnoremap <silent> <M--> :bp<cr>

nnoremap <silent> <M-=> :bp<cr>
inoremap <silent> <M-=> <Esc>:bp<cr>

nnoremap <silent> <M-b> :BufExplorer<cr>
inoremap <silent> <M-b> <Esc>:BufExplorer<cr>

nnoremap <silent> <M-e> :edit .<cr>
inoremap <silent> <M-e> <Esc>:edit .<cr>

nnoremap <silent> <M-q> :LeQuit<cr>
inoremap <silent> <M-q> <Esc>:LeQuit<cr>

nnoremap <silent> <M-x> :bd<cr>
inoremap <silent> <M-x> <Esc>:bd<cr>

nnoremap <silent> <M-d> dd
inoremap <silent> <M-d> <Esc>dd

nnoremap <silent> <M-w> :w<cr>
inoremap <silent> <M-w> <Esc>:w<cr>

inoremap <silent> <M-/> <C-p>

noremap <silent> <C-x>0 <C-W>q
noremap <silent> <C-x>1 :only<CR>
noremap <silent> <C-x>2 <C-W>i
noremap <silent> <C-x>3 <C-W>v

let mapleader=','
"noremap <leader>tg :GitGutterToggle<cr>
noremap <leader>tg :CocCommand git.toggleGutters
noremap <leader>td :NERDTreeToggle<cr>
noremap <leader>tl :set nonu relativenumber!<cr>
noremap <leader>tt :DisableAll<cr>

"nnoremap <silent><space><space> :call quickui#menu#open()<cr>
nnoremap <silent> <leader> :WhichKey ','<CR>

map ; :Files<CR>
"map " :Vg<CR>

colorscheme PaperColor

if &diff
    set background=dark
else
    colorscheme PaperColor
endif

" Sneak
let g:sneak#label = 1


" Nnn setting
let g:nnn#set_default_mappings = 0

" Then set your own
" nnoremap <silent> <leader>nn :NnnPicker<CR>
" nnoremap <leader>n :NnnPicker %:p:h<CR>
" Opens the nnn window in a split
let g:nnn#layout = 'vsplit' " or vnew, tabnew etc.
let g:nnn#layout = { 'left': '~20%' } " left or right, up, down
" Floating window (neovim latest and vim with patch 8.2.191)
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight':'Debug' } }
let g:nnn#action = {
      \ 'e': 'tabnew',
      \ 's': 'split',
      \ 'v': 'vsplit',
      \ '<cr>': 'vsplit' }

" Fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_preview_git_status_preview_command =
    \ "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} | delta || " .
    \ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} | delta || " .
    \ g:fzf_preview_command

if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Vg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(expand('<cword>')), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:python3_host_prog='python3'
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0

" MENU UI
let g:quickui_color_scheme = 'papercol dark'
call quickui#menu#reset()
call quickui#menu#install("&File", [
        \ [ "&Bookmark\t", 'BookmarkShowAll' ],
        \ [ "&AddBookmark\t", 'BookmarkAnnotate' ],
        \ [ "&New File\t", 'new' ],
	\ [ "&Open\t(:w)", 'call feedkeys(":tabe ")'],
	\ [ "&Save\t(:w)", 'write'],
	\ [ "--", ],
	\ [ "&Mru\t<C-b>", 'FZFMru'],
	\ [ "&Files\t", 'Files'],
	\ [ "--", ],
	\ [ "E&xit", 'qa' ],
	\ ])


call quickui#menu#install("&Edit", [
			\ ['Copyright &Header', 'call feedkeys("\<esc> ec")', 'Insert copyright information at the beginning'],
			\ ['&Trailing Space', 'call StripTrailingWhitespace()', ''],
			\ ['Update &ModTime', 'call UpdateLastModified()', ''],
			\ ['&Paste Mode Line', 'PasteVimModeLine', ''],
			\ ['--'],
			\ ['&Align Table', 'Tabularize /|', ''],
			\ ])

call quickui#menu#install('&Git', [
			\ ["Gutter&Next\t]c", 'GitGutterNextHunk', 'GutterNext'],
			\ ["Gutter&Prev\t[c", 'GitGutterPrevHunk', 'GutterPrev'],
			\ ["Gutter&Prev\t,gu", 'GitGutterUndoHunk', 'GutterUndo'],
			\ ["GitStatus\t,gs", 'CocCommand fzf-preview.GitStatus', 'GitStatus'],
			\ ["GitAction\t,ga", 'CocCommand fzf-preview.GitActions', 'GitAction'],
			\ ])


call quickui#menu#install('&Plugin', [
			\ ["&NERDTree\t<space>tn", 'NERDTreeToggle', 'toggle nerdtree'],
			\ ["&GitGutterToggle\t,tg", 'GitGutterToggle', 'toggle gutter'],
			\ ["&highlightSearch\t", 'HLsearchToggle', 'toggle hlsearch'],
			\ ["-"],
			\ ['&Tagbar', '', 'toggle tagbar'],
			\ ])

call quickui#menu#install('H&elp', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ["&Display Calendar", "Calendar", "display a calender"],
			\ ['--',''],
			\ ['&About', 'About', ''],
			\ ], 10000)

let g:context_menu_k = [
			\ ["Git&Action\t,ga", 'exec "CocCommand fzf-preview.GitActions"'],
			\ ["Git&Status\t,gs", 'exec "CocCommand fzf-preview.GitStatus"'],
			\ ["Git&NextHunk\t,g]", ''],
			\ ["Git&PrevHunk\t,g[", ''],
			\ ["Git&UndoHunk\t,gu", ''],
			\ ["--", ],
			\ ["G&itLog\t", 'exec "Glog"'],
			\ ["GitStatus\t", 'exec "Gstatus"'],
			\ ["Git&Diff\t", 'exec "Gdiff"'],
			\ ["Buffer &0\t", 'call quickui#tools#list_buffer("e")'],
			\ ["See&Tab\t", 'exec "SeeTab"'],
			\ ["Ta&gs\t", 'call quickui#tools#preview_tag(expand("<cword>"))'],
			\ ["&BookMark\tma", 'BookmarkShowAll'],
			\ ["Disable &Line info\t,tt", 'exec "DisableAll"'],
			\ ["&VimWiki\t,ww", 'exec "VimwikiIndex"']
			\ ]
nnoremap <silent>' :call quickui#tools#clever_context('k', g:context_menu_k, {})<cr>
nnoremap <silent><F10> :call quickui#menu#open()<cr>

function! HLsearchToggle()
    exec "set hlsearch! hlsearch?"
endfunction

" SeeTab: toggles between showing tabs and using standard listchars
fu! SeeTab()
  if !exists("g:SeeTabEnabled")
    let g:SeeTabEnabled = 1
    let g:SeeTab_list = &list
    let g:SeeTab_listchars = &listchars
    let regA = @a
    redir @a
    hi SpecialKey
    redir END
    let g:SeeTabSpecialKey = @a
    let @a = regA
    silent! hi SpecialKey guifg=black guibg=magenta ctermfg=black ctermbg=magenta
    set list
    set listchars=tab:\|\
  else
    let &list = g:SeeTab_list
    let &listchars = &listchars
    silent! exe "hi ".substitute(g:SeeTabSpecialKey,'xxx','','e')
    unlet g:SeeTabEnabled g:SeeTab_list g:SeeTab_listchars
  endif
endfunc

function! About()
    let x = ''
    redir => x
    silent! messages
    redir END
    let x = substitute(x, '[\n\r]\+\%$', '', 'g')
    let content = [" ViM Editor Special Edition for Lechee "]
    let l3=["           2020             "]
    let opts = {"close":"button"}
    let opts.title= "About"
    let opts.resize = 1
    let opts.index = 1
    call quickui#textbox#open(content, opts)
endfunc

function! BookMark()
    exec norm :BookmarkShowAll<cr>
endfunc

com! -nargs=0 About :call About()
com! -nargs=0 Bookmark :call BookMark()
com! -nargs=0 SeeTab :call SeeTab()
com! -nargs=0 HLsearchToggle :call HLsearchToggle()

"GutenTags
let g:gutentags_project_root = ['.root', '.git', '.project']
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
"let g:gutentags_file_list_command = 'rg --files'
let g:gutentags_file_list_command = 'ag -l'
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"nnoremap <silent> <C-]> :ts<cr>
"inoremap <silent> <C-]> <Esc>:ts<cr>

" Bookmark
" mm -- mark current line , mn Next,  mp Prev,  mi -- mark annotate, 
" ma -- view , mx mc -- clean
"
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"NERD comment
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

" GitGutter
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_preview_win_location = 'bo'

noremap <leader>gu :GitGutterUndoHunk<cr>
noremap <leader>g] :GitGutterNextHunk<cr>
noremap <leader>g[ :GitGutterPerviousHunk<cr>

"noremap <leader>gu :CocCommand git.chunkUndo<cr>
"noremap <leader>gd :CocCommand git.diffCached<cr>

noremap <leader>gs :CocCommand fzf-preview.GitStatus<cr>
noremap <leader>ga :CocCommand fzf-preview.GitActions<cr>
noremap <leader>' :Ripgrep<cr>

nmap <C-]> <Plug>(fzf_tags)
"nmap K :ALEDetail<cr>
"nmap K :CocDiagnostics<cr>

let g:coc_start_at_startup = v:true

imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" CocSetting
set updatetime=500
set shortmess+=c
set signcolumn=yes
set hidden

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" <--- end CocSetting


set expandtab
set tabstop=4
set shiftwidth=4
set rnu relativenumber
set number
set nobackup     " nobackup
noswapfile       " noswapfile
set nowrap
set t_Co=256
set pastetoggle=<F15>
set nowrapscan
