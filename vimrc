" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if has('nvim')
    runtime! plugin/python_setup.vim
endif

let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","

" vim-plug
" Installation:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if filereadable($HOME . "/.vim/autoload/plug.vim")
    call plug#begin('~/.vim/plugged')

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
      nnoremap <silent> <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
      nnoremap <silent> <Leader>g        :GFiles<CR>

    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
      let NERDTreeRespectWildIgnore=1
      " open NERDTree automatically when vim starts up if no files were specified
      "autocmd StdinReadPre * let s:std_in=1
      "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
      nnoremap <leader>ne :NERDTree<cr>
      let NERDTreeIgnore = ['\.pdf$']

    " syntax checking plugin
    Plug 'w0rp/ale'
    let g:ale_linters = { 'python': ['flake8'] }
    let g:ale_python_pylint_options = '--disable=missing-docstring,invalid-name,bad-continuation --max-line-length=120'
    let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

    " git wrapper with commands such as :Gstatus (see :help fugitive)
    Plug 'tpope/vim-fugitive'
    " enable Gpush output
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-surround'
    " for latex surround: https://github.com/tpope/vim-surround/issues/47
    let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

    Plug 'christoomey/vim-tmux-navigator'

    " disable for cygwin
    if has("unix") && !has("win32unix")
        " opening files with a minimal number of keystrokes
        " Build as follows:
        " cd ~/.vim/bundle/Command-T/ruby/command-t
        " ruby extconf.rb
        " make
        " Plug 'wincent/Command-T'

        Plug 'altercation/vim-colors-solarized'
    endif

    Plug 'itchyny/lightline.vim' | Plug 'maximbaz/lightline-ale'
    let g:lightline = {}
    let g:lightline.component_expand = {
          \  'linter_checking': 'lightline#ale#checking',
          \  'linter_warnings': 'lightline#ale#warnings',
          \  'linter_errors': 'lightline#ale#errors',
          \  'linter_ok': 'lightline#ale#ok',
          \ }
    let g:lightline.component_type = {
          \     'linter_checking': 'left',
          \     'linter_warnings': 'warning',
          \     'linter_errors': 'error',
          \     'linter_ok': 'left',
          \ }
    let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

    Plug 'lervag/vimtex', { 'for': 'tex' }
    let g:tex_flavor='latex'
    let g:vimtex_view_method='skim'
    let g:vimtex_toc_config={'show_help': 0, 'layers': ['content'], 'tocdepth': 2, 'refresh_always': 1}
    " let g:vimtex_quickfix_ignore_filters = ['Underfull', 'Overfull']
    " let g:tex_fast = ""

    " Plug '907th/vim-auto-save'
    " let g:auto_save_events = ["InsertLeave", "TextChanged"]
    " autocmd FileType tex let g:auto_save = 1
    " autocmd FileType tex let g:auto_save_silent = 1

    Plug 'ervandew/supertab'
    " https://github.com/ycm-core/YouCompleteMe/issues/1751#issuecomment-273380629
    " Make sure anaconda python is not in PATH during installation:
    " https://github.com/ycm-core/YouCompleteMe/issues/1241#issuecomment-335051278
    " Plug 'Valloric/YouCompleteMe', { 'do': '/usr/bin/python3 install.py' }
    Plug 'sirver/ultisnips', { 'for': 'tex' }
    Plug 'honza/vim-snippets'
    "
    " https://stackoverflow.com/a/22253548
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

    Plug 'godlygeek/tabular', { 'for': 'markdown' }
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    let g:vim_markdown_new_list_item_indent = 2
    autocmd FileType markdown setlocal nospell

    " make gx work again
    Plug 'felipec/vim-sanegx'

    call plug#end()

    " disable for cygwin
    if has("unix") && !has("win32unix")
        let g:solarized_termcolors=16
        " solarized colorscheme
        colorscheme solarized
    else
        colorscheme ron
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General (Mostly stolen from https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Latex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" see :h ft-text-syntax
let g:tex_comment_nospell=1

autocmd FileType bib setlocal nospell

set spell
set spelllang=en
set spellfile=$HOME/.dotfiles/vim/spell/en.utf-8.add

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 " Always display the statusline in all windows
let g:airline_powerline_fonts = 1
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=light
syntax on

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.aux,*.bbl,*.bcf,*.blg,*.bst,*.dvi,*.fdb_latexmk,*.fls,*.log,*.out,*.run.xml,*.synctex.gz,*.toc
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

" Stop highlighting after search https://github.com/vim/vim/pull/2198
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
  autocmd CmdlineLeave [/\?] :set nohlsearch
augroup END

" ADD byte offset to status line
" set statusline+=%o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----- OWN CUSTOM STUFF -----
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fix annoying ESC delay
" https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0

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

" no line wrapping (except for *.tex)
set nowrap
augroup WrapLineInTeXFile
    autocmd!
    autocmd FileType tex setlocal wrap
augroup END

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
cnoremap <C-A> <Home>

" ----- VIM GUI SETTINGS -----
if has("gui_running")
    set guifont=MesloLGS-NF-Regular:h17
    " macthinstrokes seems to be broken since Big Sur: https://github.com/macvim-dev/macvim/issues/1188
    set macthinstrokes
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


" copied from gabrielelana/vim-markdown plugin
" https://github.com/gabrielelana/vim-markdown/blob/master/autoload/markdown.vim#L504
function! SwitchStatus()
  let current_line = getline('.')
  if match(current_line, '^\s*[*\-+] \[ \]') >= 0
    call setline('.', substitute(current_line, '^\(\s*[*\-+]\) \[ \]', '\1 [x]', ''))
    return
  endif
  if match(current_line, '^\s*[*\-+] \[x\]') >= 0
    call setline('.', substitute(current_line, '^\(\s*[*\-+]\) \[x\]', '\1', ''))
    return
  endif
  if match(current_line, '^\s*[*\-+] \(\[[x ]\]\)\@!') >= 0
    call setline('.', substitute(current_line, '^\(\s*[*\-+]\)', '\1 [ ]', ''))
    return
  endif
  if match(current_line, '^\s*#\{1,5}\s') >= 0
    call setline('.', substitute(current_line, '^\(\s*#\{1,5}\) \(.*$\)', '\1# \2', ''))
    return
  endif
  if match(current_line, '^\s*#\{6}\s') >= 0
    call setline('.', substitute(current_line, '^\(\s*\)#\{6} \(.*$\)', '\1# \2', ''))
    return
  endif
endfunction
" }}}

autocmd FileType markdown nnoremap <silent> <Space> :call SwitchStatus()<CR>

