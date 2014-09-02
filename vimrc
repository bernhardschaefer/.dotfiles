" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" VUNDLE
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
" syntax checking plugin
Plugin 'scrooloose/syntastic'
" git wrapper with commands such as :Gstatus (see :help fugitive)
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/Command-T'
Plugin 'jnurmine/Zenburn'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()

" Mostly stolen from https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w<cr>

cmap w!! w !sudo tee > /dev/null %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" allow changing to other buffer if current buffer is modified
set hidden

" Makes search act like search in modern browsers
set incsearch

" ADD byte offset to status line 
" set statusline+=%o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----- OWN CUSTOM STUFF ----- 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" store .swap files in dedicated directory
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name/4331812#4331812
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=~/.vim/swap//

" store tilde '~' backup files in dedicated directory
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir=~/.vim/backup

" show row numbers
set number

" C-Space for completion
inoremap <C-Space> <C-x><C-o>

" automatically yank to clipboard (this means that there is an alias for "+yy
" --> yy)
set clipboard=unnamedplus

" more bash like completion
set wildmode=longest,list,full

" no line wrapping
set nowrap

" from http://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim
if has("gui_running")
  " GUI is running or is about to start.
  " Increase gvim window size.
  set lines=30 columns=100
endif

" ----- COLOR SCHEME -----
syntax on

" solarized
set background=dark
colorscheme solarized

"if !has('gui_running')
  "set term=screen-256color
"endif
" zenburn on gvim against computer vision syndrome
" this is important to be before loading the
"set t_Co=256 
"let g:zenburn_high_Contrast=1 
"colors zenburn

" ----- INDENTATION -----
" http://stackoverflow.com/questions/2861627/paste-in-insert-mode
" autoindent copies the indentation from the previous line
set autoindent
" smartindent inserts one extra level of indentation in some cases
" If you plan on using file type based indentation, don't set 'smartindent' or
" 'cindent'. You may still set 'autoindent', since it doesn't interfere.
" set smartindent

" default settings for all not specified files
set tabstop=4
set softtabstop=2
set shiftwidth=4
set noexpandtab

autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType css setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType htmldjango setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2

" ----- NERDTree -----
" don't show .pyc files in tree
let NERDTreeIgnore = ['\.pyc$']

" shortcut for NERDTree
nmap <leader>ne :NERDTree<cr>

" ----- LatexBox -----

" shortcut for LatexTOCToggle
nmap <leader>l :LatexTOCToggle<cr>
nmap <leader>m :Latexmk<cr>
nmap <leader>c :w<cr> :Latexmk<cr>


" ----- DEFAULT VIMRC ----- 

" set showcmd    " display incomplete commands

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif
