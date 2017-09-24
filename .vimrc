
" =============================================================================
" Author: lwczzhiwu
" Last_modify: 2017-08-09
" =============================================================================
" The configures of vim was originally stealed from
" https://github.com/wklken/vim-for-server
" =============================================================================


" ============================= Plugins =======================================

set nocompatible              " be iMproved, required
filetype off                  " required

" https://github.com/VundleVim/Vundle.Vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'auto-pairs'
Plugin 'w0rp/ale'
Plugin 'maralla/completor.vim'



call vundle#end()            " required
filetype plugin indent on    " required

" nathanaelkane/vim-indent-guides setting
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" w0rp/ale setting
let g:ale_enabled=0
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=0
let g:ale_sign_error='✗'
let g:ale_sign_warning='⚡'
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_statusline_format=['✗ %d', '⚡ %d', '- cz']


" ============================= basic setting ==================================

" leader
let mapleader=','
let g:mapleader=','

" syntax
syntax on

" history : how many lines of history VIM hast o remember
set history=2000

" filetype
" filetype off
" Enable filetype plugins
" filetype plugin on
" filetype indent on

" base
" set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI               " don't show default welcome message

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file
set directory=~/.vimswap,/tmp

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
au GuiEnter * set t_vb=
set tm=500

" show location
" set cursorcolumn
set cursorline

" movement
set scrolloff=7                 " keep 3 lines when scrolling

" show
set ruler                       " show the current row and column
set number                      " show line numbers
set relativenumber
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis
set list                        " show tabs and Highlight problematic whitespace
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present

" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" NOT SUPPORT
" fold
set foldenable
set foldmethod=indent
set foldlevel=99
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" complete some symbol
" inoremap ' ''<ESC>i
" inoremap " ""<ESC>i
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Enable basic mouse behavior such as resizing buffers.
" set mouse=a


" ============================= theme and status line =========================

" theme
set background=dark
" colorscheme desert
colorscheme space-vim-dark

set guifont=YaHei\ Consolas\ Hybrid\ 12
if has("gui_running")         " gui window setting
  "set lines=999 columns=999   " max window
  set lines=42 columns=178
  autocmd GUIEnter * winpos 157 78
  set guioptions-=m           " hidden menu bar
  set guioptions-=T           " hidden tool bar
  set guioptions-=r           " hidden right scrol bar
endif

" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
" statusline format: buffer and window number, file permission, file type
                   " file path, file format, file encoding, cursor position

set statusline=[B-%n\ W-%{winnr()}]\ %r%y\ %F%=[%{&ff}]\ [%{(&fenc!=''?&fenc:&enc)}%{(&bomb?\",BOM\":\"\")}]\ [%l,%c%V]\ %P\ %{ALEGetStatusLine()}
set laststatus=2   " Always show the status line - use 2 lines for the status bar


" ============================= specific file type ============================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\# -*- coding: utf-8 -*-")
    endif

    normal G
    normal o
    normal o
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun


" ============================= key map =======================================

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

noremap H ^
noremap L $

" disable direction key
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" fast jump to other window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <F10> :set nu! nu?<CR>
nnoremap <F9> :set list! list?<CR>
nnoremap <F8> :set wrap! wrap?<CR>
set pastetoggle=<F7>            "    when in insert mode, press <F7> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        " exec "!go build %<"
        exec "!time go run %"
    endif
endfunc

" kj equal Esc
inoremap kj <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>

" select all
map <Leader>sa ggVG"

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" switch # *
" nnoremap # *
" nnoremap * #

"Keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

"Map ; to : and save a million keystrokes
" ex mode commands made easy
nnoremap ; :

" save
cmap w!! w !sudo tee >/dev/null %

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
