" Leader mappings
let mapleader = ";"
let maplocalleader = "\\"

"colorscheme
autocmd vimenter * colorscheme gruvbox
set background=dark
set termguicolors

" encoding
set encoding=utf-8
set fileencoding=utf-8

""""""""""
" Pluggins

call plug#begin('~/.config/nvim/plugged')

" colorscheme
Plug 'morhetz/gruvbox'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"" ripgrep
Plug 'jremmen/vim-ripgrep'
" vimwiki
Plug 'vimwiki/vimwiki'
" Easy commenting
Plug 'tpope/vim-commentary'
" work with surrounding quotes and brackets.
Plug 'tpope/vim-surround'
" repeat tpopes plugin commands.
Plug 'tpope/vim-repeat'

" CoC - conquer of completion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" what extensions I have installed
" :CocInstall 
" 	coc-highlight " add more options ??
" 	coc-fzf-preview " TODO: vim-fzf vs this
" 	coc-r-lsp \" needs install.packages("languageserver")
" 	coc-sql
" 	coc-texlab \ coc-vimtex
" 	coc-snippets
" 	coc-python
" 	coc-jedi \" for python " TODO:bit broken ??
" 	coc-pairs
" 	coc-markdownlint \" need to set up properly
" 	coc-json \" need to set up properl
" 	coc-prettier \" need to set up properl
" 	coc-clangd \ " C/C++/Obj-C, use clang
" 	coc-cmake
"Not yet installed
" 	coc-template "TODO: bit broken ??

"" nvim-R
"Plug 'jalvesaq/Nvim-R'	", {'branch': 'stable'}
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'gaalcaras/ncm-R'

" fast within-file word replacement
Plug 'wincent/scalpel'

" Undo visualizer
Plug 'mbbill/undotree'

" colors shown in vim
" alternative to coc-highlight.
"Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

call plug#end()

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
nnoremap <M-0> :source $HOME/.config/nvim/init.vim<CR>

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

""""""""""""""""""""""""""""""""""""""""
" Pluggin related functions/mappings etc

""""""""""
" VimWiki

"" Add additional vimwikis.
"let wiki_gen={}
"let wiki_gen.path='$HOME/vimwiki'
"let wiki_gen.path_html='$HOME/vimwiki/'
"
"let wiki_uni={}
"let wiki_uni.path='$HOME/Documents/masters/vimwiki/index.wiki'
"let wiki_uni.path_html='$HOME/Documents/masters/vimwiki/'
"
"let g:vimwiki_list = [wiki_gen,wiki_uni]

""""""""""
" UndoTree
" Set undofile and undodir (see :help undo for more info.)
set undodir=$HOME/.local/share/nvim/undodir
set undofile
nnoremap <M-u> :UndotreeToggle<CR>

""""""""""""
" Commentary
nmap <LocalLeader><LocalLeader> gcl
vmap <LocalLeader><LocalLeader> gc

"""""
" CoC

"" To enable highlight current symbol on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" " jump to definition/references
"" nmap <Leader>gd <Plug>(coc-definition)
"" nmap <Leader>gr <Plug>(coc-references)
"
"" GoTo code navigation.
"nmap <silent> <Leader>gd <Plug>(coc-definition)
"nmap <silent> <Leader>gy <Plug>(coc-type-definition)
"nmap <silent> <Leader>gi <Plug>(coc-implementation)
"nmap <silent> <Leader>gr <Plug>(coc-references)
"
"" Symbol renaming.
"nmap <Leader>rn <Plug>(coc-rename)
"
"" Open link under cursor
"nmap <Leader>co <Plug>(coc-openlink)

"""""""""
" fzf 
" ripgrep

"" find project root from cwd
let g:rg_derive_root='true'

" get a popup window. If this is not wanted, then comment the line out.
let g:fzf_layout = {'window':{'width': 0.9, 'height': 0.8}} 

" Preview for fzf Files
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" just the previewer
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Preview for fzf ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" " Define RG function, that does Rg with fzf preview (should be bit better
" than Rg with larger searches ).
function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" fzf and preview integrated ripgrep
nmap <expr> <M-S-r> ':Rg '.expand('<cword>').'<CR>'
nmap <expr> <M-r> ':RG '.expand('<cword>').'<CR>'

nmap <M-f> :Files<CR>
" fzf git files
nmap <M-g> :GFiles<CR>
" fzf buffered files
nmap <M-z> :Buffer<CR>

"""""""""
"" nvim-R
"
"" ncm2 additional config from https://github.com/ncm2/ncm2
"" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
"inoremap <c-c> <ESC>
"
"" When the <Enter> key is pressed while the popup menu is visible, it only
"" hides the menu. Use this mapping to close the menu and also start a new line.
"inoremap <expr> <CR> (pumvisible() ?  "\<c-y>\<cr>" : "\<CR>")
"
"" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ?  "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : \<S-Tab>"
"
""" wrap existing omnifunc
""" Note that omnifunc does not run in background and may probably block the
""" editor. If you don't want to be blocked by omnifunc too often, you could
""" add 180ms delay before the omni wrapper:
"""	'on_complete': ['ncm2#on_complete#delay', 180, " \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
""au User Ncm2Plugin call ncm2#register_source({
""	\ 'name' : 'css', 
""	\ 'priority': 9,
""	\ 'subscope_enable': 1,
""	\ 'scope': ['css','scss'],
""	\ 'mark': 'css',
""	\ 'word_pattern': '[\w\-]+',
""	\ 'complete_pattern': ':\s*',
""	\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
""	\ })


"""""""""""""""""""
" Filetype mappings

"""
" R

"" Set <M-5> to run .R
"let R_disable_cmds = ['']
autocmd FileType r map <M-5> :!Rscript %<CR>

"" for nvim-R
"" got error that this command already existed
""command RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf
"autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") |endif
"autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif

" Autocomplete
"imap <M-Space> <C-X><C-O>

"" Use __ to make <- .
"let R_assign = 2

"" 'Send line' and 'Send selection' remap
"vmap <Leader><Space> <Plug>RDSendSelection
"nmap <Leader><Space> <Plug>RDSendLine

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
