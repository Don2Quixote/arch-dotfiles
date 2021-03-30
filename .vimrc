set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Nerdtree
Plugin 'preservim/nerdtree'
" Colorscheme
Plugin 'joshdick/onedark.vim'
" Allows to comment line on double <C-_>
Plugin 'tomtom/tcomment_vim'
" Highlights colors such as #FA4450
Plugin 'ap/vim-css-color'
" Semantic completion (After install requires compiling in
" .vim/vundle/....?/YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'
" Autocompleting of brackets and quotes
"" Plugin 'jiangmiao/auto-pairs'
" Easy navigation in file
Plugin 'easymotion/vim-easymotion'
" Airline status-line at the bottom
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Easy navigation in filesystem. <Ctrl+P> to start
Plugin 'kien/ctrlp.vim'
" Go cool support
Plugin 'fatih/vim-go'
" Simply emmet (ctrl+y+,)
Plugin 'mattn/emmet-vim'
" Minimap Ctrl+m. Requires "code-minimap" to be installed
Plugin 'wfxr/minimap.vim

call vundle#end()

filetype plugin indent on

" Show line numbers on the left side of Vim window
set number

" Make tab to be several spaces. (Not one \t symbol)
set expandtab
" Make tab to be 4 spaces (No space around "=" because of syntax specific)
set tabstop=4
" Make autoindent to be 4 spaces
set shiftwidth=4

" Make search pattern "abc" find "Abc" and even "ABC"
set ignorecase
" If capital letter in search patter then find only exact match with case cheking
set smartcase
" HighLight found elements
set hlsearch
" HighLight found elements while typing a searching query
set incsearch

" Removes delay beetween changing from insert to normal mode in airline
set ttimeoutlen=50

" Assembler highlighting
set ft=tasm

" Prevent appending top-panel on tab-auto-completing
set completeopt-=preview

" Hiding  "~" symbols after file's end
" let g:onedark_hide_endofbuffer = 1

" Setting up onedark colorscheme
let g:onedark_termcolors = 256
let g:ondedark_terminal_italics = 1

" Setting up airline theme
"" let g:airline_theme = 'dark'

" Turning on syntax highlighting and setting colorscheme
syntax on
colorscheme onedark
" Cancle colorscheme background replacement
highlight Normal ctermbg=NONE

" Change default symbols near directories in NerdTree
"" let g:NERDTreeDirArrowExpandable = '-'
"" let g:NERDTreeDirArrowCollapsible = '↘'
" Remove cringe "^G" symbol in NerdTree
let g:NERDTreeNodeDelimiter = "\u00a0"
" Do not show hidden (dot) files by default in NerdTree. (Shift + i to show them)
let g:NERDTreeShowHidden = 0
" Place NerdTree window on the right side
let g:NERDTreeWinPos = "right"
" Hide "Press ? for help" message on top of NerdTree
let g:NERDTreeMinimalUI = 1

" Show hidden files in CtrlP
let g:ctrlp_show_hidden = 1

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Close Vim if NerdTree window is the last opened window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Make Vim to jump to last remembered position in file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Mappings
let g:mapleader=','

" Make NerdTree oepn on Ctrl+e hotkey
map <C-e> :NERDTreeToggle<CR>
map <C-m> :MinimapToggle<CR>

" Make any window close on Ctrl+q
"" map <C-q> :q<CR> " Not working at unknown reason

map <Leader> <Plug>(easymotion-prefix)
