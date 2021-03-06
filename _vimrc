set noundofile
set nobackup
set nocompatible
set smartindent
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cin
set autoindent
set cursorline
let mapleader = "\<Space>"
if has('gui_running')
    set lines=40 columns=90
    set guioptions-=T
endif
syntax on
filetype plugin indent on
autocmd BufNewFile,BufRead *.cpp exec ":call SetCppFile()"
autocmd BufNewFile,BufRead *.c exec ":call SetCppFile()"
autocmd BufNewFile,BufRead *.py exec ":call SetPythonFile()"
command! -nargs=0 -bar W  exec "w"
command! -nargs=0 -bar Wq  exec "wq"

if has('win32')
    autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 253)
    set enc=utf-8
    set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
    set langmenu=zh_CN.UTF-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    set guifont=Consolas:h12
    set guifontwide=仿宋
elseif has('unix')
    set guifont=Monaco\ 12 
elseif has('mac')
    set guifont=Monaco\ 12
endif

if has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

function BracketCompletion()
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i
    inoremap ( ()<ESC>i
    inoremap [ []<ESC>i
    inoremap { {<CR>}<ESC>O
endfunction

function SetCppFile()
    call BracketCompletion()
    packadd termdebug
    map <F5> : make <CR>
    map <F6> : call Run() <CR>
    map <F7> : Termdebug %<.run <CR>
    map <F8> : call FormatCode()<CR>
    map <F9> : call Build_And_Run() <CR>
    set makeprg=g++\ \"%\"\ -o\ \"%<.exe\"\ -g\ -std=c++11\ -O2\ -Wall
endfunction

function SetPythonFile()
    call BracketCompletion()
    inoremap { {}<ESC>i
    map <F6> : ! python % <CR>
endfunction

function Run()
    if &filetype == 'cpp' || &filetype == 'c'
        if has('win32')
            exec "! \"%<.run\""
        elseif has('unix')
            exec "!time ./%<.run"
        endif
    elseif &filetype == 'sh'
        exec "!bash %"
    endif
endfunction

function Build_And_Run()
    exec "make"
    call Run()
endfunction

func! FormatCode()
    exec "w"
    if &filetype == 'cpp' || &filetype == 'c' || &filetype == 'h'
        exec "!astyle --style=ansi -n %"
        exec "e %"
    endif
endfunc

call plug#begin('$VIM/vimfiles/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
Plug 'Valloric/ListToggle'
Plug 'rakr/vim-one'
call plug#end()

set background=dark
let g:one_allow_italics = 1
colorscheme one
let g:rainbow_active = 1
