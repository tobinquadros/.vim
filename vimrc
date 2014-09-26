" vimrc
" Author: Tobin Quadros

" Leave these as the first settings.
set nocompatible " Turn off vi compatible mode
filetype off

" ==============================================================================
" VUNDLE & PLUGIN's
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" ==============================================================================

" Required by Vundle, set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Required by Vundle, keep plugin commands between vundle#begin/end.
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins on GitHub, see https://github.com/gmarik/Vundle.vim README.
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'saltstack/salt-vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" Note: use of tagbar depends on the ctags executable, see README.md.
Plugin 'majutsushi/tagbar'

" Required by Vundle, plugins must be added before this line.
call vundle#end()

" Required by Vundle, turn filetype stuff back on.
filetype plugin indent on

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ==============================================================================
" COLOR, FONT, & ENCODING
" ==============================================================================

" Always set the background to dark.
set background=dark

" Set colorscheme for 256 color terminals and GUI's
if &t_Co >= 256 || has("gui_running")
  colorscheme jellybeans
else
  colorscheme default
endif

" Set fonts, encoding, and windowing for different environments.
if &t_Co >= 256 || has("gui_running")
  if has("gui_macvim")
    set guifont=Monaco:h10
  elseif has("gui_win32")
    set guifont=Source_Code_Pro:h9:cANSI
    " Fix jacked up Windows encoding
    scriptencoding utf-8
    " Maximize window at startup.
    au GUIEnter * simalt ~x
  endif
endif

" Enable highlighting for terminals with color
if &t_Co > 2 || has("gui_running")
  syntax enable
endif

" ==============================================================================
" OPTIONS
" ==============================================================================

" Enable mouse
if has('mouse')
  set mouse=a
endif

" Editor windows
set wrap " Text wraps at terminal edge
set showbreak=... " Prefix for wrapped lines
set showmatch " Show bracket matching on insert
set matchtime=1
set list listchars=tab:→·,trail:·,nbsp:_,extends:» " show extra space characters
set number " Show line numbers
set scrolloff=2 " Scroll cursor padding (top and bottom)
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent " Copy indent when starting newline
set shiftround " Round to multiple of shiftwidth
set smartindent " Smarter autoindent
set smarttab " Smarter tabs and expanding
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab " Global settings
set omnifunc=syntaxcomplete#Complete " Set omni-completion method.

" Statusbar, vim-airline setup.
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " Always show statusbar
set ruler " Show statusbar (line,column) numbers
set report=0 " Always show number of lines changed
set showcmd " Show commands (or selections) in last line of screen
set showmode " Show INSERT, VISUAL, etc., on last line of screen

" 'Ex:' and command line settings
set wildchar=<Tab> " Character pressed to use wildcard expansion
set wildmenu " Make menu available after wildchar press
set wildmode=longest:full,full " Wildchar functionality
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.wav,*.aiff,*.aif,*.mp3,*.mp4,*.wmv

" Registers and history
set history=1000 " Save last 1000 commands from command line
" set clipboard=unnamed " I believe this needs +xterm_clipboard compilation
set pastetoggle=<F3> " Configure pastemode for external copy and paste

" Buffers
set autoread " Outside changes will be loaded
set hidden " Allow window changes with unsaved buffers
set nobackup " No backup made
set nowritebackup " No backup made
set noswapfile " Don't write .swp files
set splitbelow " Split horizontal window below current
set splitright " Split vertical window to right of current

" Searching
set hlsearch " Highlight search matches
set ignorecase " Case-insensitive searches
set incsearch " Search results are shown as they are typed
set smartcase " Recognize case-sensitive input

" ==============================================================================
" FILETYPES & AUTOCOMMANDS
" ==============================================================================

" Syntastic
let g:syntastic_check_on_open=0 " Check syntax when file is opened
let g:syntastic_aggregate_errors = 1 " Allow multiple checkers
command! -nargs=* E Explore " Fix Explore conflict if needed

if has("autocmd")

  " Enter VIMRC augroup
  augroup VIMRC

    " Clear VIMRC autocmd group command list
    autocmd!

    " Set FileTypes and syntax
    autocmd BufRead,BufNewFile .jshintrc set filetype=javascript
    autocmd BufRead,BufNewFile *.jade set filetype=jade syntax=jade
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    " Set Filetype specific tab and spacing
    autocmd FileType text setlocal textwidth=80

    " Change statusline color based on insert mode
    if version >= 700
      autocmd InsertEnter * hi StatusLine term=reverse ctermfg=245 ctermbg=52
      autocmd InsertLeave * hi StatusLine term=reverse ctermfg=245 ctermbg=234
    endif

    " Restore cursor position from last session
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Source .vimrc immediately after write
    autocmd BufWritePost .vimrc source %

  " Exit VIMRC augroup
  augroup end

endif

" ==============================================================================
" MAPPINGS
" ==============================================================================

" Remap the Leader key to spacebar
let mapleader=" "

" Escape from insert mode
inoremap jk <ESC>

" List current buffers
nnoremap <Leader>ls :ls<CR>

" Edit .vimrc file
nnoremap <Leader>ev :edit $MYVIMRC<CR>

" Netrw the current working directory
nnoremap <Leader>e. :edit .<CR>

" Netrw the directory the file is in.
nnoremap <Leader>E :Explore<CR>

" Swap back and forth between file and netrw.
nnoremap <Leader>re :Rexplore<CR>

" Remove search highlights, keep history
nnoremap <Leader>hs :nohlsearch<CR>

" Insert divider for commenting
nnoremap <Leader>#= i#<SPACE><SPACE><ESC>78i=<ESC>lx
nnoremap <Leader>/= i//<SPACE><SPACE><ESC>77i=<ESC>lx

" Run make
nnoremap <Leader>m :make<CR>

" Ctags search order: current buffer dir, current working dir, system libraries
" TODO: Make sure all the necessary directories are listed and indexed.
set tags=./tags,tags,$HOME/.vim/systags;

" To run ctags over the current working directory recursively.
nnoremap <Leader>ct :!ctags -R .

" To run ctags over the system libraries.
nnoremap <Leader>sct :!ctags -R -f $HOME/.vim/systags /usr/include /usr/local/include

" Tagbar plugin, command for quick open and close upon selection.
nnoremap <Leader>tb :TagbarOpenAutoClose<CR>

" Yank from cursor to end of line
nmap Y y$

" Allow ctrl-n/ctrl-p to filter in command line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Open quickfix window, if window is open with no errors close window
nnoremap <Leader>Q :cwindow<CR>

" Close quickfix window
nnoremap <Leader>q :cclose<CR>

" Search and replace word under cursor
nnoremap <Leader>* :%s/\<<C-r><C-w>\>//gc<LEFT><LEFT><LEFT>

" Sudo write
nnoremap <Leader>sw :w !sudo tee % >/dev/null

" ==============================================================================
" FUNCTIONS (w/ MAPPINGS)
" ==============================================================================

" Diff between modified buffer and saved file.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif
nnoremap <Leader>do :DiffOrig<CR>

" Strip trailing whitespace from lines.
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
nnoremap <Leader>ws :call StripWhitespace()<CR>

" Toggle colorcolumn with filetype textwidth.
function! ToggleColorColumn()
  " If colorcolumn is off, turn it on
  if empty(&colorcolumn)
    " If colorcolumn is off and textwidth is not set then use colorcolumn=80
    if empty(&textwidth)
      echo "colorcolumn=80"
      set colorcolumn=80
    " If colorcolumn is off and textwidth is set the use colorcolumn=+1
    else
      echo "colorcolumn=+1 (" . (&textwidth + 1) . ")"
      set colorcolumn=+1
    endif
  " If colorcolumn is on then turn it off
  else
    echo "colorcolumn="
    set colorcolumn=
  endif
endfunction
nnoremap <Leader>cc :call ToggleColorColumn()<CR>
