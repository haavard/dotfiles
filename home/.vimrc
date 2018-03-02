" -----------------
" .vimrc / init.vim
" -----------------

" Misc {{{

" special filetypes where we disable certain features (e.g. listchars)
let s:special_filetypes = ['qf', 'help', 'man', 'netrw', 'gitcommit']

" define $XDG_DATA_HOME default value if not set
if empty($XDG_DATA_HOME) | let $XDG_DATA_HOME = $HOME . '/.local/share' | endif

" }}}
" Plugins {{{

" set vim-plug locations depending on vim variant
if has('nvim')
    let s:vim_plug_location = $XDG_DATA_HOME . '/nvim/site/autoload/plug.vim'
    let s:vim_plugged_location = $XDG_DATA_HOME . '/nvim/plugged'
else
    let s:vim_plug_location = $HOME . '/.vim/autoload/plug.vim'
    let s:vim_plugged_location = $HOME . '/.vim/plugged'
endif

" autoinstall vim-plug
if empty(glob(s:vim_plug_location))
    execute 'silent !curl -fLo' s:vim_plug_location '--create-dirs'
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(s:vim_plugged_location)
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'myusuf3/numbers.vim'
Plug 'lervag/vimtex', { 'for': 'tex' }
call plug#end()

" }}}
" Options {{{

" syntax highlighting and colorscheme
set background=dark
if has('syntax')
    syntax enable
    silent! colorscheme solarized

    " highlight cursor line and 80th column
    set cursorline colorcolumn=80
end

" always show status line
set laststatus=2

" hide default mode indicator because we have lightline
set noshowmode

" enable modeline detection
set modeline modelines=5

" allow hidden buffers
set hidden

" enable line numbers
set number

" visible whitespace, if vim supports it
try
    set list listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
catch
    set nolist
endtry

" tabs
set tabstop=4      " how many cols per tab character
set softtabstop=4  " how wide an inserted tab is
set shiftwidth=4   " how much to indent
set expandtab      " use spaces instead of tabs

" ignore case in search, except when uppercase is used
set ignorecase smartcase

" disable incremental search and highlighted search results
set noincsearch
if has('extra_search')
    set nohlsearch
endif

" ignore case when completing files and directories
set wildignorecase

" start scrolling before we reach end of screen
set scrolloff=10

" disable cursor shapes in neovim
set guicursor=

" enhanced command completion
if has('wildmenu')
    set wildmenu
endif

" use + as unnamed register if possible, mapping to system clipboard
if has('unnamedplus') || has('nvim')  " nvim always has unnamedplus
    set clipboard+=unnamedplus
endif

" store undo history in undodir
if has('persistent_undo')
    set undofile
endif

" enable mouse in all modes
if has('mouse')
    set mouse=a
endif

" }}}
" Autocommands {{{

" enable word wrapping for certain file types
autocmd FileType tex,markdown let &l:textwidth = &colorcolumn

" filetype-specific formatprgs and keywordprgs
autocmd FileType c,cpp setlocal formatprg=clang-format
autocmd FileType python setlocal formatprg=yapf

" disable listchars, line numbers and colorcolumn for special filetypes
exec 'autocmd FileType ' . join(s:special_filetypes, ',') . '
\ setlocal nolist norelativenumber |
\ if has("syntax") | setlocal colorcolumn=0 | endif'

" }}}
" Plugin settings {{{

" disable numbers.vim in special filetypes
let g:numbers_exclude = s:special_filetypes

" use zathura for previewing documents with vimtex
let g:vimtex_view_method = 'zathura'

" }}}
" Commands {{{

" :W to write with sudo
command! W execute 'write !sudo tee % >/dev/null' | :edit!

" :PU to update/upgrade plugins and vim-plug itself
command! PU PlugUpdate | PlugUpgrade

" }}}
" Mappings {{{

" set leader to space and localleader to comma
let mapleader="\<Space>"
let maplocalleader=','
nnoremap <Space> <Nop>

" use jk or kj to escape from normal mode
inoremap jk <Esc>
inoremap kj <Esc>

" reselect visual after changing indent with > or <
vnoremap > >gv
vnoremap < <gv

" move logically across wrapped lines with j/k
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" backspace to edit alternative file
nnoremap <BS> <C-^>

" bubble lines up and down
nnoremap <M-k> :move -2<CR>
nnoremap <M-j> :move +1<CR>
vnoremap <M-k> :move '<-2<CR>gv
vnoremap <M-j> :move '>+1<CR>gv

" }}}

" vim: fdm=marker
