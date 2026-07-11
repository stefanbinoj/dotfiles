let mapleader = " "

" =========================
" Core
" =========================
set nocompatible
filetype plugin indent on
syntax enable

set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir
set autoread

set wrap
set linebreak
set textwidth=140

set number
set relativenumber
set scrolloff=18
set cursorline
set signcolumn=yes
set updatetime=300

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent

set nohlsearch
set incsearch
set ignorecase
set smartcase

set list
set listchars=tab:>\ ,trail:.,extends:>,precedes:<

set completeopt=menuone,noinsert,noselect
set shortmess+=c

if exists('&termguicolors')
  set termguicolors
endif

if exists('&guicursor')
  set guicursor=n:block,i-ci:ver25-blinkon500,r-cr:hor20,o:hor50
endif

set background=dark

" =========================
" Netrw
" =========================
let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25

" =========================
" Plugins
" =========================
if exists('*plug#begin')
  call plug#begin('~/.vim/plugged')

  " Simple Vim-native VS Code Dark+ theme.
  Plug 'tomasiser/vim-code-dark'

  " Vim-native LSP and completion.
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " Small editing helpers.
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'

  call plug#end()
endif

silent! colorscheme codedark

" =========================
" Plugin config
" =========================
let g:lsp_diagnostics_enabled = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_format_sync_timeout = 1000
let g:asyncomplete_auto_popup = 1

" vim-lsp-settings can install clangd/pylsp with :LspInstallServer.
let g:lsp_settings = {
      \ 'clangd': {'allowlist': ['c', 'cpp', 'objc', 'objcpp']},
      \ 'pylsp': {'allowlist': ['python']},
      \ }

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete

  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif

  nnoremap <buffer> <leader>gd :LspDefinition<CR>
  nnoremap <buffer> <leader>gr :LspReferences<CR>
  nnoremap <buffer> <leader>ca :LspCodeAction<CR>
  nnoremap <buffer> <leader>rn :LspRename<CR>
  nnoremap <buffer> [d :LspPreviousDiagnostic<CR>
  nnoremap <buffer> ]d :LspNextDiagnostic<CR>
  nnoremap <buffer> <leader>e :LspDocumentDiagnostics<CR>
  nnoremap <buffer> <leader>gf :LspDocumentFormat<CR>
endfunction

function! s:clear_yank_highlight() abort
  if exists('w:yank_highlight_match')
    silent! call matchdelete(w:yank_highlight_match)
    unlet w:yank_highlight_match
  endif
endfunction

function! s:highlight_yank() abort
  call s:clear_yank_highlight()

  let l:start = getpos("'[")[1]
  let l:end = getpos("']")[1]
  if l:start <= 0 || l:end <= 0
    return
  endif

  let l:last = min([l:end, l:start + 200])
  let w:yank_highlight_match = matchaddpos('IncSearch', map(range(l:start, l:last), '[v:val]'), 10)

  if exists('*timer_start')
    call timer_start(120, {-> s:clear_yank_highlight()})
  else
    redraw
    sleep 120m
    call s:clear_yank_highlight()
  endif
endfunction

" =========================
" Autocommands
" =========================
augroup portable_vim
  autocmd!
  autocmd VimEnter * call mkdir(expand('~/.vim/undodir'), 'p')
  autocmd FocusGained,BufEnter * checktime
  autocmd BufWritePre * %s/\s\+$//e
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  autocmd FileType c,cpp setlocal commentstring=//\ %s
  autocmd FileType python setlocal commentstring=#\ %s
augroup END

if exists('##TextYankPost')
  augroup portable_yank
    autocmd!
    autocmd TextYankPost * silent! call s:highlight_yank()
  augroup END
endif

" =========================
" Keymaps
" =========================
inoremap jk <Esc>

vnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap J mzJ`z

nnoremap <leader>pv :Ex<CR>
nnoremap <leader><CR> :source ~/.vimrc<CR>

nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap <leader>ln :lnext<CR>zz
nnoremap <leader>lp :lprev<CR>zz

nnoremap <leader>z za
nnoremap <leader>fp :echo expand('%:.')<CR>
