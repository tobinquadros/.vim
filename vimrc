" .vimrc

" LEAVE THESE AS THE FIRST SETTINGS.
set nocompatible " Turn off vi compatible mode
filetype off

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
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" FZF PLUGIN + CONFIG
if executable("fzf")
  Plugin 'junegunn/fzf'
  " Locate all files
  command! -nargs=1 Locate call fzf#run({'source': 'locate <q-args>', 'sink': 'e', 'options': '-m'})
  nnoremap <C-p> :Locate <C-R>=getcwd()<CR><CR>
  nnoremap <C-n> :Locate /<CR>
  " List of buffers
  function! BufList()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
  endfunction
  function! BufOpen(e)
    execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
  endfunction
  nnoremap <silent> <C-l> :call fzf#run({
  \   'source':  reverse(BufList()),
  \   'sink':    function('BufOpen'),
  \   'options': '+m',
  \   'down':    '40%'
  \ })<CR>
endif

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
  " Prompt to run current file from the shell, must be executable.
  nnoremap <Leader>v. :VimuxPromptCommand("./" . expand('%:t') . " ")<CR>
  " Prompt to run current file with Python interpreter
  nnoremap <Leader>vp :VimuxPromptCommand("python " . expand("%") . " ")<CR>
  " Prompt to run current file with Ruby interpreter
  nnoremap <Leader>vr :VimuxPromptCommand("ruby " . expand("%") . " ")<CR>
  " Run last command executed by :VimuxRunCommand.
  nnoremap <Leader>vl :VimuxRunLastCommand<CR>
  " Clear the runner terminal.
  nnoremap <Leader>vc :call VimuxRunCommand("clear")<CR>
  " Close vim tmux runner opened by :VimuxRunCommand.
  nnoremap <Leader>vq :VimuxCloseRunner<CR>
endif

" VIM-AIRLINE PLUGIN + CONFIG
Plugin 'bling/vim-airline'
" Only show filenames in the tab bar at the top of window.
let g:airline#extensions#tabline#fnamemod = ':t'
" Required for statusbar.
let g:airline#extensions#tabline#enabled = 1

" VIM-FUGITIVE PLUGIN + CONFIG
if executable("git")
  Plugin 'tpope/vim-fugitive'
  " Git status.
  nnoremap <Leader>gs :Gstatus<CR>
endif

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

" Set fonts, encoding, and window size for Windows to make it bearable.
if has("gui_win32")
  " Set a decent font at least.
  set guifont=Source_Code_Pro:h9:cANSI
  " Fix jacked up Windows encoding
  scriptencoding utf-8
  " Maximize window at startup.
  au GUIEnter * simalt ~x
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

    " Set FileTypes and syntax
    autocmd BufRead,BufNewFile .jshintrc set filetype=javascript
    autocmd BufRead,BufNewFile *.jade set filetype=jade syntax=jade
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    " Set Filetype specific tab and spacing
    autocmd FileType text setlocal textwidth=79
    autocmd BufRead *.py inoremap # X<c-h>#

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
nnoremap <Leader>bd :bd<CR>

" Quickfix window
nnoremap <Leader>cw :cwindow<CR>
nnoremap <Leader>ccl :cclose<CR>
nnoremap <Leader>cq :cclose<CR>
nnoremap <Leader>cn :cnext<CR>
nnoremap <Leader>cN :cNext<CR>
nnoremap <Leader>cp :cprevious<CR>

" Enter netrw
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

" Diff between modified buffer and file saved on disk, think of this as one
" step before a git diff because the file hasn't even been saved yet.
"   Use [c to jump back, or ]c to jump forward by changes.
"   Jump into the buffer you'd like to work from.
"   To obtain changes from the other file TYPE: do (the o is for obtain)
"   To put changes TYPE: dp
" USAGE: See :h :diff
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif
nnoremap <Leader>df :DiffOrig<CR>
" Turn off the diff mode.
nnoremap <Leader>do :diffoff!<CR>

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
