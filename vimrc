" .vimrc

" LEAVE THESE AS THE FIRST SETTINGS.
set nocompatible " Turn off vi compatible mode
filetype off " This is turned back on after loading plugins
runtime macros/matchit.vim " Enable better block matching

" Remap the Leader key to spacebar
let mapleader=" "

" ==============================================================================
" VUNDLE & PLUGIN's
" ==============================================================================

" Required by Vundle, set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Required by Vundle, keep plugin commands between vundle#begin/end
call vundle#begin()

" VUNDLE PLUGIN is required to be listed first
Plugin 'gmarik/Vundle.vim'

" Plugins that don't have special configuration
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" SYNTASTIC PLUGIN + CONFIG
Plugin 'scrooloose/syntastic'
" Check syntax when file is opened
let g:syntastic_check_on_open = 0
" Allow multiple checkers per file
let g:syntastic_aggregate_errors = 1
" Fix Explore conflict if needed.
command! -nargs=* E Explore

" TAGBAR PLUGIN + CONFIG
if executable("ctags")
  Plugin 'majutsushi/tagbar'
  " Command for quick open and close upon selection.
  nnoremap <Leader>tb :TagbarOpenAutoClose<CR>
  " ctags search order: current buffer dir, current working dir, system libraries
  set tags=./tags,tags,$HOME/.vim/systags;
  " Run ctags over cwd recursively, specify tags file with -f /path/to/tags
  nnoremap <Leader>ct :!ctags -R .
endif

" VIMUX PLUGIN + CONFIG
if executable("tmux")
  Plugin 'benmills/vimux'
  " Prompt to run any shell command.
  nnoremap <Leader>v! :VimuxPromptCommand<CR><C-f>
  " Run last command executed by :VimuxRunCommand.
  nnoremap <Leader>vl :VimuxRunLastCommand<CR>
endif

" VIM-AIRLINE PLUGIN + CONFIG
Plugin 'bling/vim-airline'
" Only show filenames in the tab bar at the top of window.
let g:airline#extensions#tabline#fnamemod = ':t'
" Required for statusbar.
let g:airline#extensions#tabline#enabled = 1

" Required by Vundle, plugins must be added before this line.
call vundle#end()
filetype plugin indent on

" ==============================================================================
" COLOR, FONT, & ENCODING
" ==============================================================================

" Always set the background to dark.
set background=dark

" Set colorscheme for 256 color terminals and GUI's
if &t_Co >= 256 || has("gui_running")
  silent! colorscheme jellybeans
endif

" Enable highlighting for terminals with color
if &t_Co > 2 || has("gui_running")
  syntax enable
endif

" ==============================================================================
" OPTIONS
" ==============================================================================

" Enable mouse support.
if has('mouse_sgr')
    set ttymouse=sgr
endif
if has('mouse')
  set mouse=a
endif

" Editor windows
set splitbelow " Split horizontal window below current
set splitright " Split vertical window to right of current
set nowrap " Don't wrap text til I say so
set showbreak=... " Prefix for wrapped lines
set showmatch " Show bracket matching on insert
set matchtime=1 " Show bracket match for n/10 seconds
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

" Statusbar
set laststatus=2 " Always show statusbar
set ruler " Show statusbar (line,column) numbers
set report=0 " Always show number of lines changed
set showcmd " Show commands (or selections) in last line of screen
set showmode " Show INSERT, VISUAL, etc., on last line of screen

" 'Ex:' and command line settings
set wildchar=<Tab> " Character pressed to use wildcard expansion
set wildmenu " Make menu available after wildchar press
set wildmode=longest:full,full " Wildchar functionality
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.wav,*.aiff,*.aif,*.mp3,*.mp4,*.wmv,*.sqlite3,tags

" Registers and history
set history=1000 " Save last 1000 commands from command line
set pastetoggle=<F3> " Configure pastemode for external copy and paste

" Buffers
set autoread " Outside changes will be loaded
set hidden " Allow window changes with unsaved buffers
set nobackup " No backup made
set nowritebackup " No backup made
set noswapfile " Don't write .swp files

" Searching
set hlsearch " Highlight search matches
set ignorecase " Case-insensitive searches
set incsearch " Search results are shown as they are typed
set smartcase " Recognize case-sensitive input

" ==============================================================================
" FILETYPES & AUTOCOMMANDS
" ==============================================================================

if has("autocmd")

  " Enter VIMRC augroup
  augroup VIMRC

    " Clear VIMRC autocmd group command list
    autocmd!

    " Set fileType custom behaviors
    autocmd BufRead,BufNewFile .jshintrc set filetype=javascript
    autocmd BufRead,BufNewFile *.jade set filetype=jade syntax=jade
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.py inoremap # X<c-h>#
    autocmd FileType text setlocal textwidth=79

    " Restore cursor position from last session
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  " Exit VIMRC augroup
  augroup end

endif

" ==============================================================================
" MAPPINGS (alphabetical, plugin mappings are in the Vundle section)
" ==============================================================================

" Delete current buffer.
nnoremap <Leader>bd :bdelete<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Quickfix window
nnoremap <Leader>cw :cwindow<CR>
nnoremap <Leader>ccl :cclose<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cp :cprevious<CR>

" Netrw
nnoremap <Leader>e. :edit .<CR>
nnoremap <Leader>E :Explore<CR>

" Edit vimrc file, source vimrc
nnoremap <Leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Remove search highlights, keep history
nnoremap <Leader>hs :nohlsearch<CR>

" Sudo write.
nnoremap <Leader>sw :w !sudo tee % > /dev/null

" Make current file executable.
nnoremap <Leader>x :!chmod +x %

" Insert divider for commenting
nnoremap <Leader>#= i#<SPACE><SPACE><ESC>78i=<ESC>lx
nnoremap <Leader>/= i//<SPACE><SPACE><ESC>77i=<ESC>lx

" Search and replace word under cursor.
nnoremap <Leader>* :%s/\<<C-r><C-w>\>//gc<LEFT><LEFT><LEFT>

" Vimgrep
nnoremap <Leader># :vimgrep '' **/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

" Allow ctrl-n/ctrl-p to filter in command line mode.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" ==============================================================================
" USER-DEFINED FUNCTIONS (w/ mappings)
" ==============================================================================

" Strip trailing whitespace from lines.
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
nnoremap <Leader>ws :call StripWhitespace()<CR>

" Populate arglist with files from quickfix list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let bufnr = quickfix_item['bufnr']
    if bufnr > 0
      let buffer_numbers[bufnr] = bufname(bufnr)
    endif
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

