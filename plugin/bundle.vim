"        File: bundle.vim
"      Author: Brad Phelan
"              ( bradphelan <AT> xtargets.com )
" Description: An extension to snippetsEmu to allow snippets
"              to be stored in individual files. The trigger
"              words are then derived from the file name. This
"              makes editing the snippets slightly more intuitive
"              than cryptic 'exe' statements.
"
" In a filetype directory. For example in
"
"   ~/.vim/after/ftplugin/c/bundle.vim
"
" for C or C++ snippets place the single command
"
"   FSnippets
"
" and then create files in the same directory with the
" name *.bdl. For example the file
"
"   for.bdl
"
" will contain a snippet with the trigger word 'for'  
"
" Note that within the snippets files all leading
" and trailing whitespace per line will be eliminated
" to make the code compatible with auto indenting.

function! s:Strip(str)
    let r = substitute(a:str, "\\n","","")
    let r = substitute(a:str, "\\r","","")
    let r = substitute(a:str, "\<CR>","","")
    let r = substitute(a:str, "^\\s*","","")
    let r = substitute(a:str, "\\s*$","","")
    return r
endf

" Given a file name load a Snippet from
" the file
function! FSnippet(fname)
    let trigger = fnamemodify(a:fname, ":t:r")
    let fl = readfile(a:fname)
    let fl = map(fl, 's:Strip(v:val)')
    let ft = join(fl, "\<CR>" )
    let cmd="Snippet ".trigger." ".ft
    exe cmd
endf

" Give a directory name load all the
" snippets files *.bdl in that directory.
function! FSnippets(dir)
    let s:ft = glob(a:dir . '/*.bdl')
    let s:fl = split(s:ft, "\<NL>")
    for f in s:fl
        call FSnippet(f)
    endfor
endf

" A command to load snippets from the same
" directory as the sourced script. This command
" should be placed in a file in a filetype
" directory. For example in
"
" ~/.vim/after/ftplugin/c/bundle.vim
"
" FSnippets
"
"
com! FSnippets call FSnippets(expand("<sfile>:h"))

