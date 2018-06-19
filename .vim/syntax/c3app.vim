" Vim Syntax File
" Language: C3 App
" Maintainer: Richard Hwang
" Latest Revision: 22 July 2014

if exists("b:current_syntax")
    echo "sheet"
    finish
endif

let b:current_syntax = "c3app"

syn keyword app app
syn keyword type module type
syn keyword mix mixes mixin

syn match comment "\v//.*$" contains=todo
syn keyword todo contained TODO FIXME NOTE
syntax region multi_line_comment start="\v/\*" end="\v\*/" contains=todo


hi def link app                 Preproc
hi def link module              Type
hi def link mix                 Statement

hi def link comment             Comment
hi def link multi_line_comment  Comment
hi def link todo                Todo
