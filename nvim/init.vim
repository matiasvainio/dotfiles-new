"--------------------------------------------------------------------------
" General Settings
"--------------------------------------------------------------------------

set expandtab
set shiftwidth=4
set tabstop=4
set hidden
set relativenumber
set number
set termguicolors
set hlsearch
set ignorecase
set smartcase
set mouse=a
set scrolloff=8
set sidescrolloff=8

"--------------------------------------------------------------------------
" Key maps 
"--------------------------------------------------------------------------

let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

map gf :edit <cfile><cr>

nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

vnoremap < <gv
vnoremap > >gv

imap jk <esc>

"--------------------------------------------------------------------------
" Plugins 
"--------------------------------------------------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')
source ~/.config/nvim/plugins/onedark.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/coc.vim
call plug#end()

"--------------------------------------------------------------------------
" Colorscheme
"--------------------------------------------------------------------------

colorscheme onedark

"--------------------------------------------------------------------------
" VsCode neovim settings 
"--------------------------------------------------------------------------

if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
endif
