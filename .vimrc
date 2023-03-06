call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox' 	" Colorscheme
Plug 'ctrlpvim/ctrlp.vim'        	" Fuzzy filename search
Plug 'OmniSharp/omnisharp-vim'   	" c# static analysis
Plug 'dense-analysis/ale'		" syntax checking and semantic errors
Plug 'scrooloose/nerdtree'	 	" file system explorer
Plug 'tpope/vim-surround'	 	" surroundings (parenthesis, brackets, quotes, ...)
Plug 'nathanaelkane/vim-indent-guides'	" visual indent levels
Plug 'editorconfig/editorconfig-vim'	" .editorconfig support
Plug 'prabirshrestha/asyncomplete.vim'  " autocomplete

call plug#end()

" General settings
filetype indent plugin on
if !exists('g:syntax_on') | syntax enable | endif
scriptencoding utf-8

set encoding=utf-8
set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:on
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=-1
set tabstop=8
set textwidth=80
set title
set hidden
set nofixendofline
set nostartofline
set splitbelow
set splitright
set hlsearch
set incsearch
set laststatus=2
set number
set ruler
set noshowmode
set signcolumn=yes
set mouse=a
set updatetime=1000
set wildignore+=*/tmp/*,*/obj/*,*.so,*.swp,*.zip
set paste
set showmatch " Show matching brackets/braces/parantheses
set wildmode=longest,list,full " Let TAB completion behave like bash's
set showtabline=2 " Always show tab line

" Use truecolor in the terminal, when it is supported
if has('termguicolors') | set termguicolors | endif
set background=dark
colorscheme gruvbox

augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" r: nearest path ancestor with .git/, a: directory of the current file, unless
" it is a subdirectory of the cwd
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.csproj']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|obj)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
" ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
  \ 'winblend': 30,
  \ 'winhl': 'Normal:Normal,FloatBorder:ModeMsg',
  \ 'border': 'rounded'
  \}
else
  let g:OmniSharp_popup_options = {
  \ 'highlight': 'Normal',
  \ 'padding': [0],
  \ 'border': [1],
  \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
  \ 'borderhighlight': ['ModeMsg']
  \}
endif
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}
let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
" Passthrough server to vscode's omnisharp. Example pass-through:
" 
" /opt/homebrew/Cellar/dotnet@6/6.0.114/libexec/dotnet ~/.vscode/extensions/ms-dotnettools.csharp-1.25.4-darwin-arm64/.omnisharp/1.39.4-net6.0/OmniSharp.dll "$@"
"
let g:OmniSharp_server_path = '/Users/mariano/Code/bin/omnisharp'
let g:OmniSharp_server_stdio = 1

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['nerdtree']

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

let g:syntastic_auto_loc_list=1 " Auto-open error window if errors are detected
let g:syntastic_enable_signs=1
let g:syntastic_c_check_header=1
let g:syntastic_c_no_include_search = 1 " Disable the search of included header files after special libraries
let g:syntastic_c_auto_refresh_includes=1

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0

" Shortcuts

let mapleader = "\<Space>"

" "sudo" save:
:cmap w!! w !sudo tee % >/dev/null

" tab navigation
nmap <silent> <leader><Left> :tabprevious<CR>
imap <silent> <leader><Left> <Esc>:tabprevious<CR>i
map <silent> <leader><Left> :tabprevious<CR>
nmap <silent> <leader><Right> :tabnext<CR>
imap <silent> <leader><Right> <Esc>:tabnext<CR>i
map <silent> <leader><Right> :tabnext<CR>
nmap <silent> <leader>t :tabnew<CR>
imap <silent> <leader>t <Esc>:tabnew<CR>
map <silent> <leader>t <Esc>:tabnew<CR>
map <silent> <leader>x :q<CR>
nmap <silent> <leader>s :w<CR>
imap <silent> <leader>s <Esc>:w<CR>

" Remove search highlight
nnoremap <leader><space> :noh<cr>

" buffer navigation
nnoremap <F2> :buffers<CR>:buffer<Space>

" Nerdtree shortcuts
nnoremap <leader>r :NERDTreeToggle<CR>
nnoremap <leader>e :NERDTreeFind<CR>
"

" OmniSharp shortcuts
nmap <silent> <leader>d :OmniSharpGotoDefinition<CR>
imap <silent> <leader>d <Esc>:OmniSharpGotoDefinition<CR>i
nmap <silent> <leader>i :OmniSharpFindImplementations<CR>
imap <silent> <leader>i <Esc>:OmniSharpFindImplementations<CR>i

