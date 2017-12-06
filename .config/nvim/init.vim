" === General ===
let g:mapleader="\<SPACE>"
set rtp+=~/.config/nvim/bundle/Vundle.vim/

set autoread
set visualbell              " Flash the screen in place of making the bell ring
set showcmd                 " Show command typed
set showmatch               " Show matching brackets.
set showmode                " Show current mode.
set ruler                   " Show the line and column numbers of the cursor.
set relativenumber          " Show the line numbers on the left side.
set formatoptions+=o        " Continue comment marker in new lines.
set textwidth=0             " Hard-wrap long lines as you type them.
set expandtab               " Insert spaces when TAB is pressed.
set nosmarttab
set modeline                " Enable modeline.
set linespace=0             " Set line-spacing to minimum.
set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)
set encoding=utf8           " Set encodind
set ignorecase              " Make searching case-insensitive
set smartcase               " ... unless the query has capital letters.
set gdefault                " Use 'g' flag by default with :s/foo/bar/.
set magic                   " Use 'magic' patterns (extended regular expressions).
set display+=lastline
set nostartofline           " Do not jump to first character with page commands.
set completeopt=menuone,preview,noinsert
set list                    " Show problematic characters.
set number numberwidth=4    " Disable highlight after a search
set nocompatible
set smartindent
set wrap

filetype off
filetype plugin indent on
autocmd FileType vue syntax sync fromstart
nnoremap <CR> :noh<CR><CR>
" === End General ===

" === Scroll settings ===
if !&scrolloff
    set scrolloff=7     " Show next 7 lines while scrolling.
endif
if !&sidescrolloff
    set sidescrolloff=10   " Show next 10 columns while side-scrolling.
endif
" === End Scroll settings

" === Tabulation ===
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" === End Tabulation ===

" === More natural splits ===
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
" === End More natural splits ===

" === Disable swap and backup ===
set nobackup
set noswapfile
set nowritebackup
" === End Disable swap and backup ===

" === Linebreak on 500 characters ===
set linebreak
set textwidth=500
" === End Linebreak on 500 characters ===

" === Plugins ===
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " Vim plugin manager

" Vim's theme
Plugin 'ayu-theme/ayu-vim'
Plugin 'ryanoasis/vim-devicons'

" Lightline and bar
Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'

" Productivity
Plugin 'ntpeters/vim-better-whitespace' " Strip whitespaces
Plugin 'scrooloose/nerdtree' "Sidebar
Plugin 'wakatime/vim-wakatime' "Quantify coding sessions

" Functionalities plugin
Plugin 'tpope/vim-surround' "Delete or edit surroundings in pair
Plugin 'jiangmiao/auto-pairs' "For brackets autoclosing
Plugin 'wvffle/vimterm' " Provides an easier way to interact with command-line directly from NVim
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" Languages
Plugin 'sheerun/vim-polyglot' " Provides support for various languages
Plugin 'neomake/neomake' "Make framework for cpp
Plugin 'ludovicchabant/vim-gutentags' "Tags
Plugin 'w0rp/ale'
Plugin 'fatih/vim-go'
Plugin 'jstemmer/gotags'

call vundle#end()
" === End Plugins ===

" === Colors and theme ===
set t_Co=256
set termguicolors
let ayucolor="dark"
syntax on
colorscheme ayu
" === End Colors and theme ===

" === Lightline settings ===
let g:lightline = {
    \ 'active': {
    \   'left': [['mode'], ['readonly', 'filename', 'modified'], ['tagbar', 'ale', 'gutentags']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'inactive': {
    \   'left': [['absolutepath']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'component': {
    \   'lineinfo': '%l\%L [%p%%], %c, %n',
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'ale': '%{ale#statusline#Status()}',
    \   'gutentags': '%{gutentags#statusline("[Generating...]")}'
    \ },
    \ }
" === End Lightline settings ===

" === Tagbar settings ===
nmap <F8> :TagbarOpen fj<CR>
let g:tagbar_autofocus = 0 " Focus tag bar when showing
" === EndTagbar settings ===

" === Vim-better-whitespace settings ===
autocmd BufEnter * EnableStripWhitespaceOnSave
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
let g:better_whitespace_verbosity=1
" === End Vim-better-whitespace settings ===

" === NERDTree ===
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-q> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1 " Show hidden file
let g:NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp'] " Ignore file
" === End NERDTree ===

" === Vimterm ===
nnoremap <F2> :call vimterm#toggle() <CR>
tnoremap <F2> <C-\><C-n> :call vimterm#toggle() <CR>
tnoremap <Esc> <C-\><C-n>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" === End vimterm ===

" === fzf settings ===
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_buffers_jump = 1 " Jump to the existing window if possible

noremap <Leader>z :Files<CR>
noremap <Leader>t :BTags<CR>
noremap <Leader>l :Lines<CR>
noremap <Leader>b :Buffers<CR>
noremap <Leader>h :History<CR>
" === End fzf settings ===

" === Neomake ===
let g:neomake_cpp_enabled_makers = ["gcc"]
let g:neomake_highlight_lines = 1
let g:neomake_cpp_clang_maker = {
  \ 'std':'c++11',
  \ 'args': ['-fsyntax-only', '-Wall', '-Wextra'],
  \ 'stdlib':'libc++'
\ }
" === End Neomake ===

" === Gutentags ===
let g:gutentag_enabled = 1 " Enable
let g:gutentags_cache_dir = '~/.vim/gutentags' " Where to store tag files

let g:gutentags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']
" === End Gutentags ===

" === Ale linter ===
autocmd BufEnter *.cpp,*.h,*.hpp,*.hxx let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')
let g:ale_emit_conflict_warnings = 0
let g:ale_completion_enabled = 1

let g:ale_linters = {
\   'cpp': ['clang'],
\}
" === End Ale linter ===