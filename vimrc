"=============================================================================="
" OPTIONS {{{

" Disable vi compatibility
set nocompatible

" Enable syntax highlighting
syntax on

" Change the vertical fill character to a space
set fillchars=vert:\ 

" Highlight search matches as we type
set incsearch

" Remove the buffer when a file is closed
set nohidden

" Fix backspace in insert mode
set backspace=indent,eol,start

" Makes tab completion like bash's
set wildmenu
set wildmode=list:longest

set wildignore+=*.sw?   " Ignore swp files

" Set the leader key
let mapleader = "-"
let maplocalleader = "_"

" Change indent settings
set shiftwidth=4 softtabstop=4 tabstop=8 expandtab
set smarttab
set autoindent
set formatoptions=qrcn1

set autowrite
set showcmd
set mouse=a

" Enable back ups
set backup
set noswapfile  " Swap files are annoying

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Create the directories for vim's files
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Scroll when we're within 3 lines of the edge of the window
set scrolloff=3

" Make the editor effectively 80 columns wide
set nowrap
set textwidth=80
set colorcolumn=+1

" Ignore case when doing searches
set smartcase

" Relative numbers are so useful with commands like :m!
set relativenumber

" Don't automatically change to the working directory to the file's directory
set noautochdir

" Stop the preview window from showing up
set completeopt-=preview

set list
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Disable annoying beeping
set noerrorbells
set vb t_vb=

" Set the colour to jellybeans if it exists
if filereadable($HOME . "/.vim/bundle/jellybeans.vim/colors/jellybeans.vim")
    colorscheme jellybeans

    " Highlight anything that goes over 81 columns
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%>81v.\+/

    autocmd! GuiEnter * set vb t_vb=
endif

if has("gui_running")
    set guifont=Liberation\ Mono\ 9

    " Get rid of all the window deceration that comes with gvim
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=e
    set guioptions-=L

endif

" }}}
"=============================================================================="
" MAPPINGS {{{

" Remap % to the tab key. It's just easier!
nnoremap <tab> %
vnoremap <tab> %

" Makes up and down more logical
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Goodbye help menu!
noremap <F1> <ESC>

" Cut, Copy & Paste to clipboard
vnoremap <silent> <leader>cu "+x
vnoremap <silent> <leader>cp "+y
nnoremap <silent> <leader>p :silent! set paste<CR>"+gP:set nopaste<CR>

" Select all
nnoremap <silent> <leader>a ggvG$

" Open vimrc
nnoremap <silent> <leader>ev :vsplit ~/dotfiles/vimrc<CR>

" Cycle through tabs
nnoremap <silent> <leader>h :tabprevious<CR>:silent! DoPulse<CR>
nnoremap <silent> <leader>l :tabnext<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-H> :wincmd h<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-L> :wincmd l<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-K> :wincmd k<CR>:silent! DoPulse<CR>
nnoremap <silent> <C-J> :wincmd j<CR>:silent! DoPulse<CR>

" Create new tab
nnoremap <silent> <C-t> :tabnew<CR>

" Remap gf to open file in new tab
nnoremap gf <C-W>gf

" Make blank lines and stay in normal mode
nnoremap <silent> <leader>o o<Esc>k
nnoremap <silent> <leader>O O<Esc>j

" Centers the screen on the matched search
noremap n nzz:silent! DoPulse<CR>
noremap N Nzz:silent! DoPulse<CR>

" Easy save, out of habbit
noremap <silent> <C-S> :w<CR>

" Easier start of line & end of line
nnoremap H ^
nnoremap L $

" Easier escaping
inoremap jk <esc>l
inoremap <esc> <nop>

" Always do a very magic search
nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

" Clean trailing whitespace
nnoremap <leader>cw mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Mapping for easier spell checking.
nnoremap <leader>s i<C-X><C-S>

" }}}
"=============================================================================="
" PLUGINS {{{

" VUNDLE {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-pathogen'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'lerp/linepulse'
Bundle 'L9'
Bundle 'ervandew/supertab'
Bundle 'suan/vim-instant-markdown'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/css_color.vim'
Bundle 'vim-scripts/camelcasemotion'
Bundle 'vim-scripts/AutoComplPop'
Bundle 'vim-scripts/jellybeans.vim'
Bundle 'scrooloose/syntastic'

filetype plugin indent on

" }}}
" PATHOGEN {{{

if !exists("g:loaded_pathogen")
    call pathogen#infect()
endif

" }}}
" NERDTREE {{{

augroup NERDTreeCommands
    autocmd!
    autocmd VimEnter * NERDTree
augroup END

let NERDTreeChDirMode=1
let NERDTreeIgnore=['\.pyc$']
nnoremap <silent> <F2> :NERDTreeToggle<CR>:wincmd =<CR>

" }}}
" SYNTASTIC {{{

" let g:ycm_confirm_extra_conf=0
let g:syntastic_check_on_open=1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_java_checker = 'javac'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" }}}
" LINEPULSE {{{

let g:linepulse_start = "guibg"
let g:linepulse_end   = "#606060"
let g:linepulse_steps = 30
let g:linepulse_time  = 100

" }}}
" ECLIM {{{

let g:acp_behaviourJavaEclimLength = 2
function! MeetsForJavaEclim(context)
    return g:acp_behaviourJavaEclimLength >= 0 && 
                \ a:context =~ '\k\.\k\{' . g:acp_behaviourJavaEclimLength . ',}$'
endfunction

set rtp+=~/.vim/eclim

let g:acp_behavior = {
    \ 'java': [{
        \ 'command'      : "\<c-x>\<c-u>",
        \ 'completefunc' : 'eclim#java#complete#CodeComplete',
        \ 'meets'        : 'MeetsForJavaEclim',
    \ }]
\ }

" }}}
" SUPERTAB {{{

let g:SuperTabDefaultCompletionType = "<C-N>"

" }}}
" TAGLIST {{{
    let Tlist_Auto_Open = 1
    let Tlist_Auto_Update = 1
    let Tlist_WinWidth = 35
" }}}
" POWERLINE {{{

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" }}}

" }}}
"=============================================================================="
" CUSTOM FUNCTIONS {{{

" The pairs used by SplitOther()
let g:SplitPairs = [
\   [ "h", "cpp" ],
\   [ "vert", "frag" ],
\ ]

" Opens a vertical split for relative files.
" I.e. Opening myfile.h opens myfile.cpp.
function! SplitOther()
    let fname = expand("%:p:r")

    for [leftExt, rightExt] in g:SplitPairs
        if expand("%:e") == leftExt
            set splitright
            exe "vsplit" fnameescape(fname . "." . rightExt)
            break
        elseif expand("%:e") == rightExt
            set nosplitright
            exe "vsplit" fnameescape(fname . "." . leftExt)
            break
        endif
    endfor

    exe "filetype" "detect"
    exe "wincmd" "="
endfunction

" Show the folding column
function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

nnoremap <leader>f :call FoldColumnToggle()<cr>

" Make all parent directorys and save the file
function! DirectorySave()
    call mkdir(expand('%:h'), 'p')
    write
endfunction

nnoremap <leader>w :call DirectorySave()<cr>

function! JavaProject()
    NERDTreeClose
    Tlist
    ProjectsTree
endfunction

nnoremap <leader>jp :call JavaProject()<cr>

augroup FileCommands
    autocmd!

    " Change the title string to just the file name
    autocmd BufEnter * let &titlestring = expand("%:t")

    " Resize all split windows whenever vim is resized.
    autocmd VimResized * exe "wincmd" "="

    " Attempt to open the relative file for this file
    autocmd BufRead * call SplitOther()

    " Set .BAS files to basic filetype
    autocmd BufRead *.BAS setlocal ft=basic
augroup END

" }}}
"=============================================================================="
" LANGUAGE SETTINGS {{{

" Java --------------------------------------------------------------------- {{{

function! SetupJavaEnvironment()
    set noautochdir
    set path=./**

    nnoremap <buffer> <F5> :wa<CR>:ProjectCD<CR>:Mvn compile<CR>:Mvn -q exec:java<CR>
    nnoremap <buffer> <F6> :wa<CR>:ProjectCD<CR>:Mvn compile<CR>:!mvnExec<CR>
    nnoremap <buffer> <localleader>c 0i//<esc>
    onoremap <buffer> ib  :<c-u>execute "normal! ?{\rms%hme`sv`e"<cr>
    onoremap <buffer> in( :<c-u>normal! f(vi(<cr>
    onoremap <buffer> il( :<c-u>normal! F)vi(<cr>

    nnoremap <buffer> <silent> <localleader>i :JavaImportOrganize<CR>
endfunction

augroup filetype_java
    autocmd!

    " Set up mappings
    autocmd FileType java call SetupJavaEnvironment()
augroup END

" }}}

" Vim ---------------------------------------------------------------------- {{{

augroup filetype_vim
    autocmd!

    " Enable folding for vim markers and automatically close all folds
    autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0

    " Reload the vimrc whenever it's saved
    autocmd! BufWritePost *vimrc source %
augroup END

" }}}

" Lisp --------------------------------------------------------------------- {{{

augroup filetype_lisp
    autocmd!

    " Set tab width and make program for lisp
    autocmd FileType lisp setlocal tabstop=2 shiftwidth=2 softtabstop=2
\                                  makeprg=clisp\ %
augroup END

" }}}

" C++ ---------------------------------------------------------------------- {{{

" A command for inserting a C guard macro
function! CppGuard()
    let defname = "_" . toupper(expand("%:t:r")) .
\                 "_" . toupper(expand("%:e")) . "_"

    call setline(1, "#ifndef " . defname)
    call setline(2, "#define " . defname)
    call setline(3, "")
    call setline(4, "#endif //" . defname)
endfunction

augroup filetype_cpp
    autocmd!

    " Set file syntax to C++11
    autocmd FileType h,cpp setlocal syntax=cpp11 makeprg=make

    " Use tabs instead of spaces in makefiles
    autocmd FileType makefile setlocal noexpandtab

    " Insert the Cpp Guard whenever a header file is opened
    autocmd BufNewFile *.h call CppGuard()

    autocmd FileType h,cpp setlocal foldmethod=marker foldmarker={,}
augroup END

" }}}

" Bash --------------------------------------------------------------------- {{{

augroup filetype_bash
    autocmd!

    " Execute the file when in a sh file
    autocmd FileType sh setlocal makeprg=./%
augroup END

" }}}

" Python ------------------------------------------------------------------- {{{

function! SetupPythonEnvironment()
    let g:pymode_rope = 0
    let g:pymode_doc = 1
    let g:pymode_doc_key = 'K'
    let g:pymode_lint = 1
    let g:pymode_lint_checker = "pyflakes,pep8"
    let g:pymode_lit_write = 1
    let g:pymode_virtualenv = 1
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_key = '<localleader>b'
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    let g:pymode_sytnax_space_errors = g:pymode_syntax_all

    let g:pymode_folding = 0

    nnoremap <buffer> <silent> <F5> :wa<CR>:!python %<CR>
endfunction

augroup filetype_python
    autocmd!

    " Execute the file when in a sh file
    autocmd FileType python call SetupPythonEnvironment()
augroup END

" }}}
"
" Latex -------------------------------------------------------------------- {{{

function! SetupLatexEnvironment()
    let g:LatexBox_latexmk_options = "-pvc -pdfps"
endfunction

augroup filetype_latex
    autocmd!

    autocmd FileType tex call SetupLatexEnvironment()
augroup END

" }}}
