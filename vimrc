" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" VUNDLE
" Installation
"  1. git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"  2. vim +PluginInstall +qall
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'

" syntax checking plugin
Plugin 'scrooloose/syntastic'

" git wrapper with commands such as :Gstatus (see :help fugitive)
Plugin 'tpope/vim-fugitive'

" opening files with a minimal number of keystrokes
" Build as follows:
" cd ~/.vim/bundle/Command-T/ruby/command-t
" ruby extconf.rb
" make
Plugin 'wincent/Command-T'

" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'kien/ctrlp.vim'

" Completion
" Installation:
"   cd ~/.vim/bundle/YouCompleteMe
"   ./install.sh
Plugin 'Valloric/YouCompleteMe'

Plugin 'altercation/vim-colors-solarized'

" Plugin 'LaTeX-Box-Team/LaTeX-Box'

call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Powerline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

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

" ----- COLOR SCHEME -----
syntax on
set background=light
let g:solarized_termcolors=16
" solarized colorscheme
colorscheme solarized

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

" ----- INDENTATION -----
" http://stackoverflow.com/questions/2861627/paste-in-insert-mode
" autoindent copies the indentation from the previous line
set autoindent
" smartindent inserts one extra level of indentation in some cases
" If you plan on using file type based indentation, don't set 'smartindent' or
" 'cindent'. You may still set 'autoindent', since it doesn't interfere.
" set smartindent

" default settings for all not specified files
set tabstop=4      " the width of a \t is set to 4 (only affects how \t is displayed)
set softtabstop=4  " the number of columns for a \t
set shiftwidth=4   " indent have a width of 4
set expandtab " expand tab to spaces

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" ----- NERDTree -----
" don't show .pyc files in tree
let NERDTreeIgnore = ['\.pyc$']

" shortcut for NERDTree
nmap <leader>ne :NERDTree<cr>

" ----- LatexBox -----

" shortcut for LatexTOCToggle
" nmap <leader>l :LatexTOCToggle<cr>
" nmap <leader>m :Latexmk<cr>
" nmap <leader>c :w<cr> :Latexmk<cr>

" ----- GVIM SETTINGS -----
if has("gui_running")
  set guifont=Monospace\ 11
  
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guioptions-=e  "remove tab pages

  " from http://superuser.com/questions/419372/how-do-i-set-the-default-window-size-in-vim
  " GUI is running or is about to start.
  " Increase gvim window size.
  set lines=30 columns=100
endif

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
