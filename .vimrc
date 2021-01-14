" Leader mappings
let mapleader = ";"
let maplocalleader = "\\"

"colorscheme
colorscheme gruvbox
set background=dark
set termguicolors

" encoding
set encoding=utf-8
set fileencoding=utf-8

"""""""""""""
" Set and let

"highlight search.
set hlsearch

"Do incremental searching.
set incsearch

"case insensitive search.
set ic

"number and relative number.
set relativenumber number

"show cursor position all the time.
set ruler

"display incomplete commands.
set showcmd

"display completion matches in status line.
set wildmenu

"Allow backspace over everything.
set backspace=indent,eol,start

"Add dict complete.
set complete+=kspell

"Tab is 4 char long.
set tabstop=2
" Tab inserts spaces instead
set expandtab 

"Indent to tabstop with > or <.
set shiftwidth=0

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

""Time out for key codes.
"set timeout					

""Wait up to 100ms.
"set timeoutlen=100				

"" Dont wrap text
"set nowrap

" Use sys clipboard
" ^= prepends the value and += appends the value
" Make sure xsel,xclip or analog programs exist in system.
set clipboard^=unnamed,unnamedplus 
"depr -- set clipboard+=unnamedplus		

"Enable mouse support in nvim
set mouse=nv

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c

""""""""""""""""""
" Vanilla mappings

" source vim config
nnoremap <M-0> :source $HOME/.vimrc<CR>

" Use same paste multiple times
xnoremap p pgvy

" Set spellcheck under F6.
map <F6> :setlocal spell! spelllang=en_us<CR>

" No highlight
nmap <M-p> :noh<CR>

"" Netrw tree for the current dir
"nmap <C-M-t> :edit . <CR>

" switch case of the whole word.
nmap <M-`> g~iw

" switch case of the first letter of the word under the cursor.
nmap <M-~> lb~h

"""""""
" notes 
" Vim bindings for moving; All are prepended with <C-w>
" moving - h,j,k,l 
" move - H,J,K,L 
" cycle - w
" vertical split - v, horizontal split - s

" Meta/Alt h,j,k,l to navigate splits in every mode.
nnoremap <M-j> <C-w>j
nnoremap <M-h> <C-w>h
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l

" Make new split to the given direction.
nnoremap <M-S-h> :vertical leftabove new<CR>
nnoremap <M-S-j> :belowright new<CR>
nnoremap <M-S-k> :leftabove new<CR>
nnoremap <M-S-l> :vertical belowright new<CR>

" close split
nnoremap <M-x> <C-w>c

" cycle split
nnoremap <M-Tab> <C-w>w

nnoremap <C-M-j> <C-w>+
" TODO:  use h instead of <
nnoremap <M-C-<> <C-w><
nnoremap <M-C-k> <C-w>-
nnoremap <M-C-l> <C-w>>
nnoremap <M-=> <C-w>=

" Go forward/backwards a file (in the opened buffer)
nnoremap <M-n> :bn<CR>
nnoremap <M-b> :bp<CR>

" Switch to previous file
nnoremap <M-s> <C-^>

" <C-o>/<C-i> walks back/forward in files
" <C-a>/<C-x> increments/decrements numbers

"""""""""""""""""""
" Filetype mappings

"""
" R

"" Set <M-5> to run .R
"let R_disable_cmds = ['']
autocmd FileType r map <M-5> :!Rscript %<CR>

"""""
" Rmd

"" Set <M-5> to knit .Rmd.
autocmd FileType rmd map <M-5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<CR>

"" Set <M-4> to open <rmd file>.pdf
" autocmd Filetype rmd map <M-4> :!echo<space>%<space>\|<space>sed<space>'s/\.[^.]*$//'<space>\|<space>xargs<space>-I<space>file<space>zathura<space>"file".pdf<space>&<CR><CR>
autocmd Filetype rmd map <M-4> :!zathura<Space>%:r.pdf<Space>&<CR><CR>
"
"" Set <M-C-4> to open <rmd file>.html
autocmd Filetype rmd map <M-3> :!firefox<Space>%:r.html<Space>&<CR><CR>

""""""""
" Python

" Set <M-t> to open terminal
autocmd FileType python map <M-t> :! $TERM -e screen python &<CR>

" Set <M-5> to run the python code.
autocmd FileType python map <M-5> :!python<Space>%<CR>

" Run (R,)Python etc lines in the terminal like in RStudio
" add lazyredraw, if there is flickering.
autocmd Filetype python nmap <Leader><Space> "kyy:echo system("screen -S $(ls -R /run/screens/ \| tail -n -1) -X stuff ".escape(shellescape(@k),"$"))<CR>/^.<CR>:noh<CR><CR>
autocmd Filetype python vmap <Leader><Space> "xy:echo system("screen -S $(ls -R /run/screens/ \| tail -n -1) -X stuff ".escape(shellescape(@x."\n"),"$"))<CR>/^.<CR>:noh<CR><CR>
" Run starting from cursor, select to the end of the line.
"autocmd Filetype r,python nmap \ v$<C-\>

"""""""""
" Haskell

" autocmd Filetype haskell map <M-t> :split term://stack ghci % <CR>
" Open interactive haskell terminal
autocmd Filetype haskell map  <M-t> :!<Space>$TERM<Space>-e<Space>stack<Space>ghci<Space>%<Space>&<CR>

" Compile haskell code, so it can be imported to other hs file 
" (needs to be in the same directory)

" w/ stack version
autocmd Filetype haskell map <M-2> :!stack<Space>ghc<Space>--<Space>-dynamic<Space>%:r<CR>

" w/o stack version
autocmd Filetype haskell map <M-3> :!<Space>ghc<Space>--make<Space>-dynamic<Space>%:r<CR>

" Compile haskell code
autocmd Filetype haskell map <M-4> :!<Space>stack<Space>ghc<Space>--<Space>-main-is<Space>%:r<Space>%<CR> 
"-O<Space>

" Run compiled code
autocmd Filetype haskell map <M-5> :!./%:r<CR>

"""""
" TeX
" Set <M-5> to compile TeX file
autocmd Filetype tex map <M-5> :!pdflatex<space>%<Enter>
" Set <M-4> to open compiled TeX file in zathura
autocmd Filetype tex map <M-4> :!zathura<space>%:r.pdf<space>&<Enter><Enter>

""""""""""
" Markdown
" TODO
