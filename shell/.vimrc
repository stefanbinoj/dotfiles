set scrolloff=14
set number 
set relativenumber 
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent 

call plug#begin("~/.vim/plugged")
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'tomasiser/vim-code-dark'
call plug#end()

colorscheme codedark

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.vimrc <CR>
inoremap jk <esc>
nnoremap <C-p> :GFiles<CR> 
nnoremap <leader>pf :Files<CR>
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

highlight LineNr ctermfg=LightGrey guifg=#888888
highlight CursorLineNr ctermfg=Yellow guifg=#FFFF00
