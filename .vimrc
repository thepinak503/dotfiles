# Vim Configuration
# Minimal backup configuration for systems without Neovim

" Basic settings
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

" Enable syntax highlighting
syntax on
filetype plugin indent on

" Colors
colorscheme default
set background=dark
set t_Co=256

" Enable line numbers
set number
set relativenumber

" Enable cursor line
set cursorline

" Enable wild menu
set wildmenu
set wildmode=longest:full,full

" Enable search highlighting
set hlsearch
set incsearch
set ignorecase
set smartcase

" Enable auto-indent
set autoindent
set smartindent

" Tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Enable mouse
set mouse=a

" Enable clipboard
set clipboard=unnamedplus

" Enable backspace
set backspace=indent,eol,start

" Enable hidden buffers
set hidden

" Enable ruler
set ruler

" Enable status line
set laststatus=2

" Enable line wrapping
set wrap
set linebreak

" Enable scroll offset
set scrolloff=8
set sidescrolloff=8

" Enable undo
set undofile
set undodir=~/.vim/undo

" Enable backup
set backup
set backupdir=~/.vim/backup

" Enable swap
set swapfile
set directory=~/.vim/swap

" Enable history
set history=10000

" Enable command line height
set cmdheight=2

" Enable update time
set updatetime=300

" Enable short messages
set shortmess+=c

" Enable sign column
set signcolumn=yes

" Key mappings
let mapleader = " "

" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Quit
nnoremap <C-q> :q<CR>

" Clear search
nnoremap <leader>h :nohlsearch<CR>

" Split windows
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" Buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>d :bdelete<CR>

" Indentation
vnoremap < <gv
vnoremap > >gv

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Disable arrow keys (force hjkl usage)
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Auto commands
augroup vimrc
  autocmd!
  
  " Remove trailing whitespace on save
  autocmd BufWritePre * %s/\s\+$//e
  
  " Remember cursor position
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" Netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25