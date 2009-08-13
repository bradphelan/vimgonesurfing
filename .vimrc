syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set expandtab
set sw=4
set ts=4
set sts=4
set guifont=Monospace\ 8.6

hi CursorLine guibg=Grey8
hi CursorColumn guibg=Grey8


set runtimepath=$VIMRUNTIME,~/vimfiles/vcs,~/vimgonesurfing,~/vimgonesurfing/after
colorscheme torte

imap jj 

" normal mode whitespace inserters
nmap  i
nmap <space> i<space><esc>l
nmap <tab> i<tab><esc>l

nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/
vnoremap ; "hy:%s/<C-r>h//gc<left><left><left>

let g:mapleader=','
let g:maplocalleader=','

" The comment format options seems to be broken by default
" for python
au BufNewFile,BufRead *.py,SConstruct,SConscript set nocindent
au BufNewFile,BufRead *.py,SConstruct,SConscript set nosmartindent
au BufNewFile,BufRead *.py,SConstruct,SConscript set fo=croq
au BufNewFile,BufRead *.py,SConscript,SConscript set comments=sO:*-,mO:*,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-
set comments=sO:*-,mO:*,exO:*/,s1:/*,mb:*,ex:*/,f://,b:#,:%,:XCOMM,n:>,fb:-

" set the cindent options 
set cinoptions+=g0,t0

" automatic bracket inserting
imap [ []<esc>i
imap ( ()<esc>i
imap { {}<esc>kk$a
imap [] []
imap () ()
imap {} {}

" jump to the end of the next bracket
imap ,, <esc>/[)\]}]<cr>a

" remap gf for svn typefiles
au FileType svn nnoremap <buffer> gf sgf:SVNVimDiff<cr>

" turn on mode lines
set modeline
set modelines=5

" load doxygen syntax
let g:load_doxygen_syntax=1

" set the omni complete function for cpp
au FileType cpp set omnifunc=omni#cpp#complete#Main


function! CppSyn()


    syntax cluster xOperators contains=xOperator1,xOperator2,xOperator3,xOperator4,xOperator5,xOperator6

    syntax region xBlock1 start=/\(\w\+\)\(::\w\+\)*</ end=/>/ contains=iBlock1
    syntax region iBlock1 start=/</ms=s+1 end=/>/me=e-1 contained containedin=xBlock1 contains=xBlock2

    syntax region xBlock2 start=/\(\w\+\)\(::\w\+\)*</ end=/>/ contains=iBlock2
    syntax region iBlock2 start=/</ms=s+1 end=/>/me=e-1 contained containedin=xBlock2 contains=xBlock1 


    " ensure we don't match Foo::Bar::operator<< as the beginning of a
    " template
    syntax match xOperator1 "\(\w\+::\)*operator<<" 

    " Create some sexy colors
    hi xBlock1 guifg=#44ff44
    hi xBlock2 guifg=#ff4444
    hi iBlock1 guifg=#4444ff
    hi iBlock2 guifg=#ff44ff

endf

function! Yaml()
    setlocal ts=2
    setlocal sw=2
endf
au FileType qf call CppSyn()
au FileType yaml call Yaml()

" Load test template files
au BufNewFile test_*.cpp %delete | 0r templates/generic/test_basic.cpp

" Open split window in file browser to the right
let g:netrw_altv = 1


highlight Pmenu guibg=darkblue

"Build the current file
com Make exec "make " . expand("%:r") . ".os"

" Copy the path of the file into the unamed buffer
nmap cp :let @* = expand("%")<cr>
nmap cP :let @* = expand("%:p")<cr>

