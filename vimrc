" ---------------------------------------------------------------------------
"  Pathogen (must be set up before filetype detection)
" ---------------------------------------------------------------------------

" system's .vimrc calls filetype; turn it off here to force reload
filetype on " turn on to avoid non-zero exit code on OSX
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ---------------------------------------------------------------------------
"  General
" ---------------------------------------------------------------------------

set nocompatible           " we're running Vim, not Vi!
set modelines=0            " prevent security exploits
set tabpagemax=10          " open 50 tabs max
filetype plugin indent on  " load filetype plugin
set history=100            " lots of command line history

" ----------------------------------------------------------------------------
"  Backups
" ----------------------------------------------------------------------------

set nobackup               " do not keep backups after close
set nowritebackup          " do not keep a backup while working
set noswapfile             " don't keep swp files either
set backupdir=~/.vim/backup " store backups under ~/.vim/backup
set backupcopy=yes         " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,. " keep swp files under ~/.vim/swap

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set number                 " show line numbers
set ruler                  " show the cursor position all the time
set scrolloff=3            " start scrolling before cursor at end
set showcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set wildmenu               " turn on wild menu (better filename completion)
set wildmode=list:longest,full
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=atI          " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set linebreak              " wrap long lines between words
colorscheme jellybeans

" ----------------------------------------------------------------------------
"  Visual Cues
" ----------------------------------------------------------------------------

syntax on                  " enable syntax highlighting
let loaded_matchparen=1    " don't hightlight matching brackets/braces
set laststatus=2           " always show the status line
set hlsearch               " highlight all search terms
set incsearch              " highlight search text as entered
set ignorecase             " ignore case when searching
set smartcase              " case sensitive only if capitals in search term
set colorcolumn=80        " not available until Vim 7.3
highlight ColorColumn ctermbg=233 " highlight the set column
set visualbell             " shut the fuck up

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------

set softtabstop=4
set shiftwidth=4           " distance to shift lines with < and >
set ts=4                   " tab character display size
set tabstop=4
set expandtab              " expand tabs to spaces
set autoindent
set smartindent
set smarttab
set nowrap

" ----------------------------------------------------------------------------
"  Autocommands
" ----------------------------------------------------------------------------

function! MakeExecutable()
  silent !chmod a+x %
endfunction

" on save, make file executable if has shebang line with '/bin/'
au BufWritePost * if getline(1) =~ "^#!/bin/" | :call MakeExecutable() | endif

" ---------------------------------------------------------------------------
"  Variables
" ---------------------------------------------------------------------------

let maplocalleader = ","
let g:ackprg="ack-grep\\ -H\\ --nocolor\\ --nogroup\\ --column" " for Ack plugin

" ----------------------------------------------------------------------------
"  Mappings
" ----------------------------------------------------------------------------

" kj to exit insert mode
imap kj <Esc>

" Y to yank to end of line
map Y y$

" Ctrl-x to close current buffer
map <C-x> :q<CR>

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" ,; opens ~/.vimrc
map ,; :tabe ~/.vimrc<CR><C-W>_

" ,: reloads .vimrc
map <silent> ,: :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" move up and down by screen lines instead of text lines
nnoremap j gj
nnoremap k gk

" faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" easy file saving
map <C-s> :w<CR>

" easy ack
nnoremap <LocalLeader>a :Ack 

" change directory to that of current file
cmap cdc cd %:p:h

" Unmap arrow keys
no <down> ddp
no <left> <Nop>
no <right> <Nop>
ino <up> dkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
vno <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>"

" Quick save
noremap <Leader>w :update<CR>
vnoremap <Leader>w :update<CR>
""inoremap <Leader>w :update<CR>

" Quick quit
noremap <Leader>q :quit<CR>
vnoremap <Leader>q :quit<CR>
""inoremap <Leader>q :quit<CR>

" Indent code blocks
vnoremap < <gv
vnoremap > >gv

" Format paragraphs
vmap Q qq
nmap Q gqap


" ---------------------------------------------------------------------------
"  Split Navigation
" ---------------------------------------------------------------------------

" go left, right, up, down
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" ---------------------------------------------------------------------------
"  Spell Checking
" ---------------------------------------------------------------------------

" ,ss toggles spell checking
map <LocalLeader>ss :setlocal spell!<cr>

" spell checking shortcuts (next, prev, add, suggest)
map <LocalLeader>sn ]s
map <LocalLeader>sp [s
map <LocalLeader>sa zg
map <LocalLeader>s? z=

" ---------------------------------------------------------------------------
"  Handling Whitespace
" ---------------------------------------------------------------------------

"  strip trailing whitespace
map <LocalLeader>ks :%s/\s\+$//g<CR>

"  convert tabs to spaces
map <LocalLeader>kt :%s/\t/  /g<CR>

"  kill DOS line breaks
map <LocalLeader>kd :%s///g<CR>

" ---------------------------------------------------------------------------
"  Copy/Paste Shortcuts
" ---------------------------------------------------------------------------

" copy to system clipboard
vmap <C-c> "+y

" paste in NORMAL mode from system clipboard (at or after cursor)
nmap <LocalLeader>V "+gP
nmap <LocalLeader>v "+gp

" paste in INSERT mode from Vim's clipboard (unnamed register)
imap vp <ESC>pa

" paste in INSERT mode from system clipboard
imap vv <ESC>"+gpa

" paste in COMMAND mode from Vim's clipboard (unnamed register)
cmap vp <C-r>"

" paste in COMMAND mode from system clipboard
cmap vv <C-r>+

" ----------------------------------------------------------------------------
"  Graphical
" ----------------------------------------------------------------------------

if has('gui_running')

  if system("uname") == "Darwin\n" " on OSX
    set guifont=Monaco:h12
    set lines=55
    set columns=94
  else                         " on Ubuntu
    set guifont=Monospace\ 9
    winpos 1100 0              " put window at right edge of left monitor
    set lines=85
    set columns=120
  endif

  colorscheme jellybeans
  set guioptions=gemc          " show menu, tabs, console dialogs

  " --------------------------------------------------------------------------
  "  Highlight Trailing Whitespace
  " --------------------------------------------------------------------------

  " note that this inhibits the linebreak option so lines will wrap mid-word
  set list listchars=trail:.,tab:>.
  highlight SpecialKey ctermfg=DarkGray ctermbg=Black

  " --------------------------------------------------------------------------
  "  Tab Navigation
  " --------------------------------------------------------------------------

endif

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>


" ----------------------------------------------------------------------------
"  Plugins
" ----------------------------------------------------------------------------

" python-mode
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
let g:pymode_virtualenv = 1
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
""autocmd vimenter * NERDTree
""autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" ctrlp
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" pep8
let g:pep8_map='<F8>'
