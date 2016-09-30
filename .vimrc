"-------------------GUI ---------------------
colorscheme jellybeans
if has('gui_running')
  set guifont=xft:Inconsolata\ for\ Powerline\ 10
endif
scriptencoding utf-8
set encoding=utf-8

" ------------------ GLOBAL ------------------
let mapleader=","
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=blue
set cursorline
set cursorcolumn
filetype plugin on
set omnifunc=syntaxcomplete#Complete
map <C-n> :NERDTreeToggle<CR>
"set spell
"set spelllang=sv,en
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" ----------------- USABILITY ----------------
set ignorecase
set smartcase
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
execute pathogen#infect()
" ---------------- INDENT -------------------
set autoindent
set shiftwidth=2
set tabstop=2

" --------------- MAPPINGS ------------------
map Y y$
nnoremap <C-L> :nohl<CR><C-L>

" --------------- LIGHTLINE -----------------
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠'._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
hi TabLineFill term=bold cterm=bold ctermbg=100
" Hardmode Vim no arrowkeys just hjkl 
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
