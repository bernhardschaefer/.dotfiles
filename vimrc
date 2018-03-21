" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if has('nvim')
    runtime! plugin/python_setup.vim
endif

" VUNDLE
" Installation
"  1. git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"  2. vim +PluginInstall +qall
if isdirectory($HOME . "/.vim/bundle/Vundle.vim")
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'scrooloose/nerdtree'

    " syntax checking plugin
    Plugin 'scrooloose/syntastic'

    " git wrapper with commands such as :Gstatus (see :help fugitive)
    Plugin 'tpope/vim-fugitive'

    Plugin 'christoomey/vim-tmux-navigator'

    " disable for cygwin
    if has("unix") && !has("win32unix")
        " opening files with a minimal number of keystrokes
        " Build as follows:
        " cd ~/.vim/bundle/Command-T/ruby/command-t
        " ruby extconf.rb
        " make
        " Plugin 'wincent/Command-T'

        " Completion
        " Installation:
        "   cd ~/.vim/bundle/YouCompleteMe
        "   ./install.sh
        " Plugin 'Valloric/YouCompleteMe'

        Plugin 'altercation/vim-colors-solarized'
    endif

    Plugin 'itchyny/lightline.vim'

    " Plugin 'LaTeX-Box-Team/LaTeX-Box'

    call vundle#end()

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 " Always display the statusline in all windows
let g:airline_powerline_fonts = 1
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ----- COLOR SCHEME -----

set background=dark
syntax on

" disable for cygwin
if has("unix") && !has("win32unix") && isdirectory($HOME . "/.vim/bundle/vim-colors-solarized")
    let g:solarized_termcolors=16
    " solarized colorscheme
    colorscheme solarized
else
    colorscheme ron
endif

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
set relativenumber
set number

" automatically yank to clipboard (this means that there is an alias for "+yy
" --> yy)
set clipboard^=unnamed,unnamedplus

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

" ----- Mappings -----

" Insert mode mappings:
" C-Space for completion
inoremap <C-Space> <C-x><C-o>

" Normal mode mappings:
nnoremap <leader>w :w<cr>
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" remove trailing whitespace with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" easier switching between splits
" TODO: https://teamgaslight.com/blog/vim-plus-tmux-a-perfect-match
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Control mode mappings:
cnoremap w!! w !sudo tee > /dev/null %

" ----- NERDTree -----
" don't show .pyc files in tree
let NERDTreeIgnore = ['\.pyc$']

" shortcut for NERDTree
nnoremap <leader>ne :NERDTree<cr>

" ----- LatexBox -----

" shortcut for LatexTOCToggle
" nnoremap <leader>l :LatexTOCToggle<cr>
" nnoremap <leader>m :Latexmk<cr>
" nnoremap <leader>c :w<cr> :Latexmk<cr>

" ----- GVIM SETTINGS -----
if has("gui_running")
    set guifont=Menlo\ Regular:h15
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
