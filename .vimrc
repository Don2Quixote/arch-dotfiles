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
Plugin 'wfxr/minimap.vim'
" Git marks (new, changed, removed). <Leader>gitt to toggle.
Plugin 'airblade/vim-gitgutter'

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

" Prevent gitgutter from mapping keys (I actually don't know it's maps, I
" defined my own)
let g:gitgutter_map_keys = 0
" Prevent gitgutter launch by default. It takes some space to display signs
" near the lines' numbers
let g:gitgutter_enabled = 0
" Change default sigs (+, ~, -) to these prettier ones
let g:gitgutter_sign_added = '▋'
let g:gitgutter_sign_modified = '▋'
let g:gitgutter_sign_removed = '▋'
let g:gitgutter_sign_removed_first_line = '▋'
let g:gitgutter_sign_removed_above_and_below = '▋'
let g:gitgutter_sign_modified_removed = '▋'
" Make gitgutter update oftener than roughly speaking never
set updatetime=74

" Mappings
let g:mapleader=','

map <C-e> :NERDTreeToggle<CR>
map <C-m> :MinimapToggle<CR>

" Some vim-go mappings
map <Leader>goi :GoImports<CR>
map <Leader>goI :GoImport 
map <Leader>goc :GoCoverage<CR>
map <Leader>goC :GoCoverageClear<CR>
map <Leader>gor :GoRename 
map <Leader>god :GoDef<CR> " Cool to use with Ctrl+w Ctrl+v
map <Leader>goD :GoDefPop<CR>

map <Leader>gitt :GitGutterToggle<CR>
map <Leader>gitn :GitGutterNextHunk<CR>
map <Leader>gitN :GitGutterPrevHunk<CR>
map <Leader>gitf :GitGutterFold<CR>

map <Leader> <Plug>(easymotion-prefix)
