" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" PLUGINS

" Install vim-plug if it isn't already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start installing plugins
call plug#begin('~/.local/share/nvim/plugged')

" Vim enhancements
Plug 'ciaranm/securemodelines'

" GUI
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'dense-analysis/ale'

" Completion plugins
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'lervag/vim-latex'
Plug 'rust-lang/rust.vim'
Plug 'keith/swift.vim'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'uarun/vim-protobuf'
Plug 'vmchale/ion-vim'
Plug 'lervag/vimtex'
Plug 'elmcast/elm-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'derekwyatt/vim-scala'

call plug#end()

" PLUGIN SETTINGS

" ncm2
let g:python3_host_prog = '/usr/local/bin/python3'
set completeopt=noinsert,menuone,noselect

" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

augroup ncm2
    au!

    au BufEnter * call ncm2#enable_for_buffer()
augroup END

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls']
    \ }

" ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_linters = {
    \ 'rust': ['rls'],
    \ 'go': ['gopls'],
    \ 'c': ['clangd'],
\ }

let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \ 'javascript': ['eslint', 'prettier'],
    \ 'rust': ['rustfmt'],
\ }

let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_rust_rls_config = {
    \ 'rust': {
        \   'all_targets': 1,
        \   'all_features': 1,
        \   'build_on_save': 1,
        \   'clippy_preference': 'on'
    \ }
\ }

let g:ale_virtualtext_cursor = 1

highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <leader>r :ALERename<CR>

" Lightline
let g:lightline = { 'colorscheme': 'wombat' }
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" LANGUAGE SETTINGS

" Rust
augroup rust
    au!

    au Filetype rust set makeprg=cargo\ build
augroup END
" rust.vim
let g:rustfmt_command = '~/.cargo/bin/rustup run nightly rustfmt'
let g:rustfmt_autosave = 1

" LaTeX
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

let g:vimtex_imaps_leader = ';'
let g:tex_flavor = 'latex'

augroup latex
    au!

    " Set filetype correctly for .cls files
    au BufNewFile,BufRead *.cls set syntax=tex

    au Filetype tex setlocal shiftwidth=2
    au Filetype tex setlocal softtabstop=2
    au Filetype tex setlocal tabstop=2

    au Filetype tex setlocal fo-=c
    au Filetype tex setlocal fo+=tc

    au Filetype tex set makeprg=ninja
augroup END

" Markdown
let g:vim_markdown_folding_disabled = 1

" Ruby
augroup ruby
    au!

    " Set filetype correctly for Podfiles
    au BufNewFile,BufRead Podfile set syntax=ruby
augroup END

" JavaScript, CSS, HTML, etc.
augroup js
    au!

    au BufRead,BufNewFile *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html setlocal expandtab shiftwidth=2 softtabstop=2
augroup END

" EDITOR SETTINGS

filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
" set signcolumn=yes
set number relativenumber

inoremap <M-o> ø

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use 4-space indentation
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Wrapping options
set fo=c " wrap text and comments using textwidth
set fo+=r " continue comments when pressing ENTER in I mode
set fo+=q " enable formatting of comments with gq
set fo+=a " automatically reformat paragraphs while typing
set fo+=w " only wrap lines that end in whitespace
set fo+=n " detect lists for formatting
set textwidth=100

" Proper search
set incsearch
set ignorecase
set smartcase

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Suspend
nnoremap <leader>ss :sus<cr>

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" KEYBOARD SHORTCUTS

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Copy and paste from outside nvim
noremap <leader>p "+p
noremap <leader>y "+y

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Build commands
noremap M :make<cr>
noremap MM :!cd %:p:h \| make<cr>

" Window splitting
nmap <silent> <leader>sh :leftabove vnew<cr>
nmap <silent> <leader>sl :rightbelow vnew<cr>
nmap <silent> <leader>sk :leftabove new<cr>
nmap <silent> <leader>sj :rightbelow new<cr>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Scroll the window next to the current one (especially useful for two-window split)
nmap <silent> <leader>j <c-w>w<c-d><c-w>W
nmap <silent> <leader>k <c-w>w<c-u><c-w>W

" Toggle search highlighting
nmap <silent> <leader>/ :set hlsearch!<cr>

" Write buffer through sudo
cnoreabbrev w!! w !sudo tee % >/dev/null

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
