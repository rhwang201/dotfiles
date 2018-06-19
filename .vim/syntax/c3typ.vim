" Vim Syntax File
" Language: C3 Type
" Maintainer: Richard Hwang
" Latest Revision: 17 July 2014

if exists("b:current_syntax")
    echo "sheet"
    finish
endif

let b:current_syntax = "c3typ"

syn keyword primitives string int date float double decimal boolean json
syn keyword data map function
syn keyword type_next type mixes entity mixin

syn keyword describers stored calc dyn enum

syn keyword moduleKeywords module ui remix
syn keyword interface abstract extendable

syn keyword import import
syn keyword todo contained TODO FIXME NOTE

syn match comment "\v//.*$" contains=todo

syntax region string start=/\v'/ skip=/\v\\./ end=/\v'/
syntax region multi_line_comment start="\v/\*" end="\v\*/" contains=todo


hi def link primitives          Constant
hi def link string              String

hi def link data                Type
hi def link type_next           Type
hi def link moduleKeywords      Type

hi def link describers          Identifier

hi def link interface              PreProc
hi def link import              Statement

hi def link comment             Comment
hi def link multi_line_comment  Comment
hi def link todo                Todo
