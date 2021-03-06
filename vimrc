"Load Bunldes with Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Auto Commands
if has("autocmd")
  " enable filetype detection
  filetype plugin indent on

  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  "automatically source config on write
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

let mapleader = "\\"

" Tabbing
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
nmap <silent> <leader>t :retab<CR>

" Appearance
"set ruler " Display ruler
set number " Show line numbers
set title " Display filename in title bar
" colorscheme sunburst
set background=dark " Adapt color scheme for dark backgrounds
syntax enable " Enable syntax highlighting
"set cursorline "Adds highlighted line on current line
set t_Co=256 " Enabled 256 color mode (needed for screen/tmux)
"let g:Powerline_symbols = "fancy"

"Searching
set hlsearch "Highlight found searches
set incsearch
nnoremap <leader><space> :noh<CR>

" Misc
set nocompatible " Disable vi compatibility mode
set nobackup "don't create backup files
set ignorecase "ignore case in searched
set backspace=eol,start,indent "setup backspace
set ai "autoindent
set si "smart indent
set cindent "cindent
set ofu=syntaxcomplete#Complete "Enable syntax completion
set modelines=0 "disable the use of modelines
set encoding=utf-8
"set ttyfast

set spelllang=en_us " Set spell check language

" Toggle Spell Checking
nmap <silent> <leader>s :set spell!<CR>

" Show Invisibles
set list
set listchars=tab:>-
nmap <silent> <leader>l :set list!<CR>

" Line Wrapping
set wrap "enable line wrapping
set linebreak "unable soft wrapping

"Save when lose focus
au FocusLost silent! :wa

" Scrolling
set scrolloff=10
set sidescrolloff=10

"NERDTree
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['.vim$', '\~$']

function! ShowFunc(sort)
  let gf_s = &grepformat
  let gp_s = &grepprg
  if ( &filetype == "c" || &filetype == "php" || &filetype == "python" ||
    \ &filetype == "sh" )
    let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m'
    let &grepprg = 'ctags -x --'.&filetype.'-types=f --sort='.a:sort
  elseif ( &filetype == "perl" )
    let &grepformat='%*\k%*\ssubroutine%*\s%l%*\s%f %m'
    let &grepprg = 'ctags -x --perl-types=s --sort='.a:sort
  elseif ( &filetype == "vim" )
    let &grepformat='%*\k%*\sfunction%*\s%l%*\s%f %m'
    let &grepprg = 'ctags -x --vim-types=f --language-force=vim --sort='.a:sort
  endif
  if (&readonly == 0) | update | endif
  silent! grep %
  cwindow 10
  redraw
  let &grepformat = gf_s
  let &grepprg = gp_s
endfunc

nmap <leader>f :call ShowFunc("yes")<CR>

"Gui options
if has("gui_running")
  set guioptions=egmrt "Disable menu bar for gvim/macvim
  set guifont="Menlo for Powerline":h12
  let g:Powerline_symbols = "fancy"
  set transparency=10
endif
