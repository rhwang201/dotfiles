setlocal foldmethod=expr
setlocal foldexpr=Getc3typFold(v:lnum)
setlocal foldlevel=20

" Group signatures with their bodies.
function! s:Getc3typFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

" Return the number of shiftwidths lnum is indented.
function! s:IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

" Return the line number of the next non blank line, or -2 if not found.
function! s:NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction 
