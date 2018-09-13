" Make Vim more useful
set nocompatible
filetype plugin on 
" off
" Enable syntax highlighting
syntax on
set ttyfast
set lazyredraw

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'ervandew/supertab'

Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'
Plugin 'othree/vim-jsx'
Plugin 'mattn/emmet-vim'
Plugin 'henrik/vim-yaml-flattener'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'christoomey/vim-sort-motion'
Plugin 'vimwiki/vimwiki'

" Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" ES2015 code snippets (Optional)
Plugin 'epilande/vim-es2015-snippets'

" React code snippets
Plugin 'epilande/vim-react-snippets'
"Plugin 'ternjs/tern_for_vim'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required

" Plugin 'Valloric/YouCompleteMe'
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" " If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" Let ctrl p show dotfiles
let g:ctrlp_show_hidden = 1

" jsx
let g:jsx_ext_required = 0

" All of your Plugins must be added before the following line

" Colors
set background=dark
colorscheme solarized

let mapleader = "\\"

set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
"set binary
"set noeol
set nofixendofline

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Highlight current line
set cursorline
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" shortcuts
" NERDTREE
map <leader> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>r :call RenameFile()<cr>

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Highlight tabs and trailing spaces
set list listchars=tab:>-,trail:.,extends:>

" better motion between panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FIND AND REPLACE ACROSS FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FindAndReplace()
    let find_this = expand('<cword>')
    let replace_with = input('Replace "'.expand('<cword>').'" with: ')
    :exec "args `" . 'ack -l ' . find_this . "`"
    " eventignore-=Syntax enables syntax highlighting w/argdo
    :exec "argdo set eventignore-=Syntax \| %s/" . find_this ."/" . replace_with "/g " . "\| w"
endfunction
map <leader>f :call FindAndReplace()<cr>noremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STRIP OUT THE CARET M BULLSHITE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StripCaretM()
  exec ':%s/
//g'
endfunction
map <leader>m :call StripCaretM()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE UNDO BETTER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile
set undodir=~/.vim/undodir
"set directory=~/.vim/swap

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
"set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" statusline
"
" %< means truncate on the left if too long
" %F is full path to the file we are editing
set statusline=%<%F
" %m shows [+] if the file is modified but not saved
set statusline+=%m
" %r shows [RO] if a file is read-only
set statusline+=%r
" %h shows [Help] if we are in a help buffer
set statusline+=%h
" %w shows [Preview] if we are in a preview window
set statusline+=%w
" separation point between the left and right items
set statusline+=%=
" prints the fileformat; that is, the kind of newline (one of unix, dos or
" mac)
" (If you type `:set fileformat?`, vim will tell you the current file
" format)
set statusline+=%{&fileformat}
" a literal forward slash
set statusline+=/
" %Y shows the filetype, such as VIM or HTML or GO
set statusline+=%Y
" %l shows the line number, and %8l uses 8 left-padded spaces to do so
set statusline+=%8l
" a literal comma
set statusline+=,
" %v shows the virtual column number;
" instead of counting a tab as one char, it counts it as the number
" of spaces it uses in the display
" %-8v leaves 8 spaces to the right to do so
set statusline+=%-8v

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log()<Esc><S-f>(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p

"enable keyboard shortcuts
"let g:tern_map_keys=1
"show argument hints
"let g:tern_show_argument_hints='on_hold'

" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = { 'javascript': ['eslint'], }

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1

" Enable completion where available.
" let g:ale_completion_enabled = 1

" Always leave gutter open
" let g:ale_sign_column_always = 1

let g:ale_lint_delay = 20
let g:ale_completion_delay = 10
let g:ale_lint_on_enter = 1
let g:ale_open_list = 1
let g:ale_javascript_prettier_use_local_config = 1

highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(81,999),",")

" Import FZF
set rtp+=/usr/local/opt/fzf

inoremap '' `

" autoload vim
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost ~/.vimrc source $MYVIMRC
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
