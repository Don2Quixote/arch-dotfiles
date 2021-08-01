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

" I actually have forgotten what do next 3 lines do
filetype plugin indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Set different identation rules for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" minimap settings
let g:minimap_width = 10
let g:minimap_git_colors = 1

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
" If capital letter in search pattern then find only exact match with case cheking
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

" Leave only stdout of program in log (supress debugger's inforarmation)
let g:go_debug_log_output = ''

" Prevent gitgutter from mapping keys (I actually don't know it's maps, I
" defined my own)
let g:gitgutter_map_keys = 0
" Force gitgutter to launch by default.
let g:gitgutter_enabled = 1
" Change default sigs (+, ~, -) to these prettier ones
let g:gitgutter_sign_added = '▋'
let g:gitgutter_sign_modified = '▋'
let g:gitgutter_sign_removed = '▋'
let g:gitgutter_sign_removed_first_line = '▋'
let g:gitgutter_sign_removed_above_and_below = '▋'
let g:gitgutter_sign_modified_removed = '▋'
" To make gitgutter update oftener than roughly speaking never
set updatetime=74

" Show full path to file in airline
let g:airline_section_c = '%F'
" Reduce mode's names  ('N' instead of 'NORMAL', 'I' instead of 'INSERT', etc.)
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n' : 'N',
      \ 'ic': 'I',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'c' : 'C',
      \ 'v' : 'V',
      \ 'V' : 'V',
      \ 's' : 'S',
      \ 'S' : 'S',
      \ }

" Incredibly Speed up ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" the_silver_searcher must be installed
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" This probably helps with gopls's performance
let g:ycm_gopls_args = ['-remote=auto', '-listen.timeout=15s']
let g:ycm_gopls_binary_path = $HOME . '/.go/bin/gopls'

" Mappings
let g:mapleader=','

map <Leader> <Plug>(easymotion-prefix)

nmap <C-e> :NERDTreeToggle<CR>
nmap <C-m> :MinimapToggle<CR>

" Some vim-go mappings
autocmd FileType go nmap <Leader>imps :GoImports<CR>
autocmd FileType go nmap <Leader>impm :GoImport 
autocmd FileType go nmap <Leader>cov :GoCoverageToggle<CR>
autocmd FileType go nmap <Leader>ren :GoRename 
autocmd FileType go nmap <Leader>def :GoDef<CR>
autocmd FileType go nmap <Leader>Def <C-w>v<C-w>T:GoDef<CR>
autocmd FileType go nmap <Leader>p :GoDefPop<CR>
autocmd FileType go nmap <Leader>bug :tab split<CR>:GoDebugStart<CR>

" Default vim-go's debugger's mappings are stupid and becomes disabled somewhy
autocmd FileType go nmap db :GoDebugBreakpoint<CR>
autocmd FileType go nmap dS :tab split<CR>:GoDebugStart<CR>
autocmd FileType go nmap dSS :GoDebugStop<CR>
autocmd FileType go nmap dc :GoDebugContinue<CR>
autocmd FileType go nmap ds :GoDebugStep<CR>
autocmd FileType go nmap dn :GoDebugNext<CR>
autocmd FileType go nmap dp :GoDebugPrint<CR>

" Sooqa, it's hard to use it
nmap <Leader>gitt :GitGutterToggle<CR>
nmap <Leader>gitu :GitGutterUndoHunk<CR>
nmap <Leader>gitn :GitGutterNextHunk<CR>
nmap <Leader>gitN :GitGutterPrevHunk<CR>
nmap <Leader>gitf :GitGutterFold<CR>

" Open current file in new tab (duplicate current tab)
nmap dup <C-w>v<C-w>T

" Remap ctrlp to work by default in local directory only. Leader+ctrlP will
" scann entire project directory
let g:ctrlp_map = ''
map <Leader><C-p> :CtrlP<CR>
map <C-p> :CtrlPCurWD<CR>


