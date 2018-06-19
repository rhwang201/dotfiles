" Richard Hwang
" June 2015

" TODO
" Fold only functions, not inner folds
"
" function! EqualSplitAll()
"   tabd vertical resize &columns/2
" endfunction
"
" function to control p visually selected filename


" Bundles
call pathogen#infect()

" ***************************
" *  Settings               *
" ***************************

" Coloring
filetype off
syntax on
filetype plugin indent on

" Intelligent searching
set incsearch
set ignorecase
set smartcase
set showmatch

" Leave 3 lines visible
set scrolloff=3

" Show what I'm typing
set showcmd

" Cursor coordinates
set ruler

" White space
set sw=4 sts=4 ts=4 et
set backspace=indent,start,eol
set autoindent

" Line numbers
set number

" Search Highlight
set hlsearch

" Hides buffers instead of closing
set hidden

" Horizontal cursorline
set cursorline

" Mouse scrolling
set mouse=nicr

" Line widths
set textwidth=89
set formatoptions=qrn1
if exists('+colorcolumn')
  set colorcolumn=90
else
  augroup highlight_length
    autocmd!
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
  augroup END
endif

" swp files are annoying
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

" ***************************
" *  Mappings               *
" ***************************

" God how do people live without these
nnoremap ; :
inoremap jj <esc>

" My brave leader
let mapleader = ","
let maplocalleader = "\\"

" Clear search highlight
nnoremap <leader>cs :nohl<cr>

" Commenting
augroup commenting
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
augroup END

" Edit .vimrc
nnoremap <leader>ev :vspl $MYVIMRC<cr>
nnoremap <leader>evh :spl $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Quote word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" Panes
nnoremap <leader>w <C-w>v<C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
set splitbelow
set splitright

" Hide line numbering
nmap <leader>l :setlocal number!<cr>

" Keel the whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let@/=''<cr>

" Textwidth
nnoremap <leader>tw gggqG<cr>

" Paste mode
nnoremap <leader>p :set paste<cr>:put  *<cr>:set nopaste<cr>

" Reposition to middle and top
nnoremap <space> zz
nnoremap tt zt

" LaTeX
nnoremap <leader>lt :!pdflatex %<cr>

" Tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <c-n> gt
inoremap <c-n> <esc>gt
nnoremap <c-p> gT
inoremap <c-p> <esc>gT

" Move current tab into the specified direction.
"
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    " get number of tab pages.
    let ntp=tabpagenr("$")
    " move tab, if necessary.
    if ntp > 1
        " get number of current tab page.
        let ctpn=tabpagenr()
        " move left.
        if a:direction < 0
            let index=((ctpn-1+ntp-1)%ntp)
        else
            let index=(ctpn%ntp)
        endif

        " move tab page.
        execute "tabmove ".index
    endif
endfunction
nnoremap <leader>tl :call TabMove(-1)<cr>
nnoremap <leader>tr :call TabMove(+1)<cr>

" Abbreviations
iabbrev mynm Richard Hwang
iabbrev myem richard.hwang201@gmail.com
iabbrev pmat \begin{pmatrix}\end{pmatrix}

" Filetype specifig abbreviations
augroup iff
  autocmd!
  autocmd FileType python     :iabbrev <buffer> iff if:<left>
  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup END

" Better file navigation
let g:ctrlp_map = '<c-o>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn)$',
    \ }
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" Folding
nnoremap <tab> za
set foldmethod=indent   " Default
set foldlevelstart=20

nnoremap <leader>rl tabdo exec 'windo e'


" Why is this not a built-in Vim script function?!
function! Get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" JSHint
nnoremap <leader>jh :JSHint<cr>

set statusline+=%F

" Vim Fugitive 
nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gd :Gdiff<cr>

" Copy/pasting
set clipboard=unnamed

" Quotes are being hidden in json files.
set conceallevel=0

" Solarized
syntax enable
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

" In visual mode, select and then enter '//' to search for selected text.
vnoremap // y/<C-R>"<CR>
