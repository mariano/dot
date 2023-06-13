call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'        " Colorscheme
Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy filename search
Plug 'DavidEGx/ctrlp-smarttabs'         " Add tabs to ctrl-p
Plug 'OmniSharp/omnisharp-vim'          " c# static analysis
Plug 'dense-analysis/ale'               " syntax checking and semantic errors
Plug 'scrooloose/nerdtree'              " file system explorer
Plug 'ryanoasis/vim-devicons'           " file icons in nerdtree
Plug 'tpope/vim-surround'               " surroundings (parenthesis, brackets, quotes, ...)
Plug 'nathanaelkane/vim-indent-guides'  " visual indent levels
Plug 'editorconfig/editorconfig-vim'    " .editorconfig support
Plug 'prabirshrestha/asyncomplete.vim'  " autocomplete
Plug 'itchyny/lightline.vim'            " status bar
Plug 'shinchu/lightline-gruvbox.vim'    " status bar theme
Plug 'maximbaz/lightline-ale'           " status bar syntax checking
Plug 'nickspoons/vim-sharpenup'         " mappings, code-actions available flag and statusline integration
Plug 'tpope/vim-obsession'              " sessions
Plug 'romainl/vim-qf'                   " quickfix fixes
Plug 'szw/vim-maximizer'     " split maximizing toggle

call plug#end()

" Functions

function CheatsheetFilter(id, key)
    if a:key == "q"
        call popup_close(a:id)
        return v:true
    endif
    return v:false
endfunction

function Cheatsheet()
    call popup_create([
    \    " buffer:     ⇥ o: open         ·   ⇥ p: open tab     . ⇥ e: tree toggle  ·   ⇥ f: open tree    . ⇥ x: exit", 
    \    "             ⇥ t: new tab      ·   ⇥ 1: tab left     . ⇥ 2: tab right    .   ⇥ s: save         . ⇥ w: close",
    \    "",
    \    " split:      ⇥ =: split horiz  · ⇥ |: split vertic   . ⇥ z: split zoom",
    \    "             ⇥ ←: split left   . ⇥ →: split right    . ⇥ ↑: split up     .   ⇥ ↓: split down",
    \    "             ⇥ j: split size ← . ⇥ l: split size →   . ⇥ i: split size ↑ .   ⇥ k: split size ↓",
    \    "",
    \    " navigate:   C-u: page up      .   C-d: page down    ·   H: top          ·     M: middle       ·   L: bottom",
    \    "               B: full word ←  ·     W: full word →  ·   b: word ←       ·     w: word →",
    \    "               0: start        ·     ^: first        ·   $: end          ·    gg: fof          ·   G: eof",
    \    "              F8: quickfix     ·    F9: locations    ·   F10: buffers    ·   F12: clean search",
    \    "",
    \    " highlight:  ⇥ h: highl line   ·   ⇥ c: clear highl",
    \    "",
    \    " .net:        F2: rename       ·    F3: peek def     ·  F4: goto def     ·    F5: impl         ·  F6: usages",
    \    "              F7: code issues",
    \    "",
    \    " tmux:     ⌥ ⌘ ↑: up           · ⌥ ⌘ ↓: down         · ⌥ ⌘ ←: left       · ⌥ ⌘ →: right",
    \    "           S ⌘ ↑: size up      · S ⌘ ↓: size down    · S ⌘ ←: size left  · S ⌘ →: size right",
    \ ], #{
    \    title: ' Cheatsheet (q to close)',
    \    pos: 'center', 
    \    padding: [],
    \    close: 'click',
    \    line: 1,
    \    border: [],
    \    zindex: 300,
    \    filter: 'CheatsheetFilter'
    \ })
endfunction

" General settings
filetype indent plugin on
if !exists('g:syntax_on') | syntax enable | endif

set encoding=utf-8
scriptencoding utf-8
set guifont=IntelOne\ Mono:h11
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
set list
set listchars=tab:⇥.,trail:-,nbsp:·,extends:>,precedes:<

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

highlight LineHighlight ctermbg=darkgray guibg=darkgray

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
let g:ctrlp_extensions = ['smarttabs']
let g:ctrlp_smarttabs_modify_tabline = 1
let g:ctrlp_smarttabs_exclude_quickfix = 1

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
let g:OmniSharp_selector_ui = 'ctrlp'
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

let g:syntastic_auto_loc_list = 1 " Auto-open error window if errors are detected
let g:syntastic_enable_signs = 1
let g:syntastic_c_check_header = 1
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

" quickfix and location windows
let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1
let g:qf_auto_resize = 1
let g:qf_auto_quit = 1
let g:qf_save_win_view = 1
let g:qf_shorten_path = 3

" Shortcuts

let mapleader = "\<tab>"

" "sudo" save:
cmap w!! w !sudo tee % >/dev/null

" tab navigation
nnoremap <silent> <leader>1 :tabprevious<CR>
noremap <silent> <leader>2 :tabnext<CR>
nnoremap <silent> <leader>t :tabnew<CR>
inoremap <silent> <leader>t <Esc>:tabnew<CR>
noremap <silent> <leader>t <Esc>:tabnew<CR>
nmap <silent> <leader>w :q<CR>
imap <silent> <leader>w <Esc>:q<CR>
map <silent> <leader>w :q<CR>
nmap <silent> <leader>s :w<CR>
imap <silent> <leader>s <Esc>:w<CR>
map <silent> <leader>s :w<CR>
nmap <silent> <leader>o :CtrlP<CR>
imap <silent> <leader>o <Esc>:CtrlP<CR>
map <silent> <leader>o :CtrlP<CR>
nmap <silent> <leader>p :CtrlPSmartTabs<CR>
imap <silent> <leader>p <Esc>:CtrlPSmartTabs<CR>
map <silent> <leader>p :CtrlPSmartTabs<CR>
noremap <silent> <C-o> :CtrlPSmartTabs<CR>
nmap <silent> <leader>x :qa<CR>
imap <silent> <leader>x <Esc>:qa<CR>
map <silent> <leader>x :qa<CR>

" Split navigation
nnoremap <silent> <leader>= :split<CR>
nnoremap <silent> <leader>\ :vsplit<CR>
nnoremap <silent> <leader><Up> <C-W>k
nnoremap <silent> <leader><Down> <C-W>j
nnoremap <silent> <leader><Left> <C-W>h
nnoremap <silent> <leader><Right> <C-W>l
nnoremap <silent> <leader>z :MaximizerToggle<CR>
nnoremap <silent> <leader>l <C-W><
nnoremap <silent> <leader>j <C-W>>
nnoremap <silent> <leader>k <C-W>-
nnoremap <silent> <leader>i <C-W>+

" Line highlight
nnoremap <silent> <Leader>h :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
nnoremap <silent> <Leader>c :call clearmatches()<CR>

" More navigation
nnoremap <silent> <F1> :call Cheatsheet()<CR>
nnoremap <silent> <F8> :call qf#toggle#ToggleQfWindow(0)<CR>
nnoremap <silent> <F9> :call qf#toggle#ToggleLocWindow(0)<CR>
nnoremap <silent> <F10> :buffers<CR>:buffer<Space>
nnoremap <silent> <F12> :noh<cr>

" Nerdtree shortcuts
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>

" OmniSharp shortcuts
nnoremap <silent> <F2> :OmniSharpRename<CR>
inoremap <silent> <F2> <Esc>:OmniSharpRename<CR>
nnoremap <silent> <F3> :OmniSharpPreviewDefinition<CR>
inoremap <silent> <F3> <Esc>:OmniSharpPreviewDefinition<CR>
nnoremap <silent> <F4> :OmniSharpGotoDefinition tabedit<CR>
inoremap <silent> <F4> <Esc>:OmniSharpGotoDefinition tabedit<CR>
nnoremap <silent> <F5> :OmniSharpFindImplementations<CR>
inoremap <silent> <F5> <Esc>:OmniSharpFindImplementations<CR>
nnoremap <silent> <F6> :OmniSharpFindUsages<CR>
inoremap <silent> <F6> <Esc>:OmniSharpFindUsages<CR>
nnoremap <silent> <F7> :OmniSharpGlobalCodeCheck<CR>
inoremap <silent> <F7> <Esc>:OmniSharpGlobalCodeCheck<CR>

" navigation
nmap <silent> <C-b> b
imap <silent> <C-b> <Esc>b
vmap <silent> <C-b> b
nmap <silent> <C-f> w
imap <silent> <C-f> <Esc>w
vmap <silent> <C-f> w

" shift+arrow selection
nmap <silent> <S-Up> v<Up>
nmap <silent> <S-Down> v<Down>
nmap <silent> <S-Left> v<Left>
nmap <silent> <S-Right> v<Right>
vmap <silent> <S-Up> <Up>
vmap <silent> <S-Down> <Down>
vmap <silent> <S-Left> <Left>
vmap <silent> <S-Right> <Right>
imap <silent> <S-Up> <Esc>v<Up>
imap <silent> <S-Down> <Esc>v<Down>
imap <silent> <S-Left> <Esc>v<Left>
imap <silent> <S-Right> <Esc>v<Right>

" clipboard support
vnoremap <silent> <C-c> :w !pbcopy<CR><CR>
noremap <silent> <C-v> :r !pbpaste<CR><CR>
