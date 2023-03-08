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
Plug 'itchyny/lightline.vim'		" status bar
Plug 'shinchu/lightline-gruvbox.vim'	" status bar theme
Plug 'maximbaz/lightline-ale'		" status bar syntax checking
Plug 'nickspoons/vim-sharpenup'		" mappings, code-actions available flag and statusline integration

call plug#end()

" General settings
filetype indent plugin on
if !exists('g:syntax_on') | syntax enable | endif
scriptencoding utf-8

set encoding=utf-8
set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:on
set wildoptions=pum
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
  \ 'file': '\v\.(exe|so|dll|swo|swp)$'
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
\ 'pageDown': ['<C-d>', '<PageDown>'],
\ 'pageUp': ['<C-u>', '<PageUp>']
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
augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_linters = { 'cs': ['OmniSharp'] }

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

let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  }
\}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

" Shortcuts

let mapleader = "\<tab>"

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

function CheatsheetFilter(id, key)
    if a:key == "q"
        call popup_close(a:id)
        return v:true
    endif
    return v:false
endfunction

function Cheatsheet()
    call popup_create([
    \    "  VIM :       H: top           ·      M: middle        ·      L: bottom",
    \    "              B: full word ←   ·      W: full word →   ·      b: word ←     ·      w: word →",
    \    "              0: start         ·      ^: first         ·      $: end        ·     gg: fof        · G: eof",
    \    "            C-u: page up       ·    C-d: page down     .    C-p: open file",
    \    "",
    \    " tmux :   ⌥ ⌘ ↑: up            ·  ⌥ ⌘ ↓: down          ·  ⌥ ⌘ ←: left       ·  ⌥ ⌘ →: right",
    \    "          S ⌘ ↑: size up       ·  S ⌘ ↓: size down     ·  S ⌘ ←: size left  ·  S ⌘ →: size right",
    \    "",
    \    " .NET :      F5: peek def      ·     F6: goto def      ·     F7: find impl",
    \ ], #{
    \    title: ' VIM cheatsheet ',
    \    pos: 'center', 
    \    padding: [],
    \    close: 'click',
    \    line: 1,
    \    border: [],
    \    zindex: 300,
    \    filter: 'CheatsheetFilter'
    \ })
endfunction

" buffer navigation
nnoremap <silent> <F1> :call Cheatsheet()<CR>
nnoremap <F3> :buffers<CR>:buffer<Space>
nnoremap <expr> <F2> empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'

" Nerdtree shortcuts
nnoremap <leader>w :NERDTreeToggle<CR>
nnoremap <leader>e :NERDTreeFind<CR>

" OmniSharp shortcuts
map <silent> <F5> :OmniSharpPreviewDefinition<CR>
imap <silent> <F5> <Esc>:OmniSharpPreviewDefinition<CR>
nmap <silent> <leader>d :OmniSharpGotoDefinition<CR>
imap <silent> <leader>d <Esc>:OmniSharpGotoDefinition<CR>i
nmap <silent> <F6> :OmniSharpGotoDefinition<CR>
imap <silent> <F6> <Esc>:OmniSharpGotoDefinition<CR>
nmap <silent> <leader>i :OmniSharpFindImplementations<CR>
imap <silent> <leader>i <Esc>:OmniSharpFindImplementations<CR>i
nmap <silent> <F7> :OmniSharpFindImplementations<CR>
imap <silent> <F7> <Esc>:OmniSharpFindImplementations<CR>
nmap <silent> <leader>r :OmniSharpFindUsages<CR>
imap <silent> <leader>r <Esc>:OmniSharpFindUsages<CR>i

" navigation
nmap <C-b> b
imap <C-b> <Esc>b
vmap <C-b> b
nmap <C-f> w
imap <C-f> <Esc>w
vmap <C-f> w

" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

" clipboard support
vnoremap <C-c> :w !pbcopy<CR><CR>
noremap <C-v> :r !pbpaste<CR><CR>

