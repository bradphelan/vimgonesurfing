" Modified indent function for C++ files.
"
" This is designed to fix some faults in the built-in VIm cindent() function. In
" particular, it formats lists of parameters with one parameter per line, and
" with a leading ',' on the line, so that the commas all line up below the
" corresponding open parenthesis
"
" It also lines up multi-line i/o operations, so the leading '<<' or '>>' all
" appear lined up below each other.
"
"   What we do depends on the following:
"   If current line's first non-blank char is ','
"       If prior line's first non-blank char is not ','
"           use cindent-2
"       Endif
"   Else If first non-blank char is '<' or '>'
"       If next char matches first non-blank
"           Look for the first occurence of the same token on prior line
"           and use that as the indent.
"       Endif
"   Else
"       If prior line ends in '('
"           use cindent+1
"       Else If prior line ends in '='
"           use cindent+4
"       Else
"           use cindent
"       Endif
"   Endif
"
if (!exists("*CppIndentDepth"))
   function CppIndentDepth()
       let lnum=v:lnum
       let ind=cindent(lnum)
       let inum=match(getline("."), "\\S")
       let ichar=getline(".")[inum]
       let rind=ind
       if ichar == ','
           if getline(lnum-1)[ind] != ','
               let rind = (ind - 2)
           endif
       elseif ichar =~ '[<>]'
           if getline(".")[inum+1] == ichar
               let matchit = ichar . ichar
               let pos = match(getline(line(".")-1), matchit)
               if pos != -1
                   let rind = pos
               endif
           endif
       else
           let pline = getline(lnum-1)
           let lastnb = matchstr(pline, "\\S\\s*$")[0]
           if lastnb == '('
               let rind = ind + 1
           elseif lastnb == '='
               let rind = ind + 4
           endif
       endif
       return rind
   endfunction
endif

set indentexpr=CppIndentDepth()
set indentkeys=0{,0},0),:,0#,!^F,o,O,e,0\,,0(

