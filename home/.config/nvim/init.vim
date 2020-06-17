" =============
" INITIAL SETUP
" =============

" Set the shell nvim uses to bash
set shell=/bin/bash

" Set the leader key to space
let mapleader = "\<Space>"

" =======
" PLUGINS
" =======

" Install vim-plug if it isn't already
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start installing plugins
call plug#begin('~/.local/share/nvim/plugged')

" Appearance
" ----------
" Display an info bar (lightline) at the bottom of the screen
Plug 'itchyny/lightline.vim'
" Highlight the region just yanked
Plug 'machakann/vim-highlightedyank'
" Only display relative numbers in places that make sense
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Editing
" -------
" Expand or contract the current selection
Plug 'terryma/vim-expand-region'
" Jump to an instance of two characters (rather than 1 with default f)
Plug 'justinmk/vim-sneak'

" Files
" -----
" Change working directory to the project root when opening a file
Plug 'airblade/vim-rooter'
" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Semantic language support
" -------------------------
" Language server support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Completion support
Plug 'lifepillar/vim-mucomplete'

" Syntactic language support
" --------------------------
" Languages under active use
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'lervag/vimtex'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
" Other languages
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vmchale/ion-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'uarun/vim-protobuf'
Plug 'jparise/vim-graphql'
Plug 'unisonweb/unison', { 'rtp': 'editor-support/vim' }
Plug 'keith/swift.vim'
Plug 'derekwyatt/vim-scala'
Plug 'elmcast/elm-vim'
Plug 'gleam-lang/gleam.vim'
" Extra tools
Plug 'godlygeek/tabular'

" Utility
" -------
" Protection against modeline vulnerability
Plug 'ciaranm/securemodelines'

" Finish installing plugins
call plug#end()

" ===============
" PLUGIN SETTINGS
" ===============

" lightline.vim
" -------------
" Turn off default nvim display of current mode, because it's shown in lightline
set noshowmode
" Set a colour scheme and add a custom filename pattern.
let g:lightline = {
    \   'colorscheme': 'deus',
    \   'component_function': {
    \       'filename': 'LightlineFilename',
    \   },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" vim-expand-region
" -----------------
" Use v when in visual mode to expand the current selection, and C-v to contract it
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" vim-rooter
" ----------
" Set file and directory patterns for detection of project root
let g:rooter_patterns = ['Cargo.toml', '.gitignore', '.git', '.git/']

" fzf.vim
" -------
" Shrink the size of the fzf file finder window
let g:fzf_layout = { 'down': '~20%' }
" Open a fuzzy file finder with C-p and a fuzzy buffer finder with leader-;
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" coc.nvim
" --------
" List of language server extensions to install if they aren't already
let g:coc_global_extensions = [
    \ "coc-clangd",
    \ "coc-git",
    \ "coc-html",
    \ "coc-json",
    \ "coc-markdownlint",
    \ "coc-omnisharp",
    \ "coc-rls",
    \ "coc-sourcekit",
    \ "coc-yaml",
    \ ]
" Customise some of the colours used in the Coc Pmenu
hi CocFloating ctermbg=black
" Always show the signcolumn, and give it a transparent background
set signcolumn=yes
hi SignColumn ctermbg=none
" Rename the symbol under the cursor with <leader>rn
nmap <silent> gr <Plug>(coc-rename)
" Jump to the definition with gd
nmap <silent> gd <Plug>(coc-definition)
" Jump to implementations with gi
nmap <silent> gi <Plug>(coc-implementation)
" Jump to usages with gu
nmap <silent> gu <Plug>(coc-references)
" Show documentation in the preview window for the symbol under the cursor when pressing K
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" vim-mucomplete
" --------------
" mucomplete says this option is required
set completeopt=menu
set completeopt+=menuone
set completeopt+=noinsert
" Turn off completion messages
set shortmess+=c
" Turn off auto-completion at startup
let g:mucomplete#enable_auto_at_startup = 0
" Set up completion chains
let g:mucomplete#chains = {
\   'default': ['tags', 'nsnp'],
\   'rust': {
\     'default': ['omni', 'nsnp'],
\     'rustString.*': [],
\     'rustComment.*': ['spel'],
\   },
\   'vim' : {
\     'default': ['cmd', 'nsnp', 'keyn'],
\     'vimComment.*': [],
\     'vimString.*': ['spel']
\   },
\ }

" rust.vim
" --------
" Turn on automatic formatting on save using nightly rustfmt
let g:rustfmt_command = 'rustup run nightly rustfmt'
let g:rustfmt_autosave = 1

" vimtex
" ------
" Explicitly specify that TeX is always really LaTeX
let g:tex_flavor = 'latex'
" Set the leader key for insert-mode bindings
let g:vimtex_imaps_leader = ';'

" vim-markdown
" ------------
" Disable automatic folding of sections in Markdown files
let g:vim_markdown_folding_disabled = 1

" =================
" LANGUAGE SETTINGS
" =================

" LaTeX
" -----
augroup latex
    au!

    " Set filetype correctly for .cls files
    au BufNewFile,BufRead *.cls setlocal syntax=tex

    " Set indentation levels for LaTeX files
    au Filetype tex setlocal shiftwidth=2 softtabstop=2

    " In LaTeX files, we want to wrap both "normal text" and comments.
    au Filetype tex setlocal fo-=c
    au Filetype tex setlocal fo+=tc

    " Build TeX files with ninja, not make, when running a make keybinding
    au Filetype tex setlocal makeprg=ninja
augroup END

" JavaScript and Web Languages
" ----------------------------
augroup web
    au!

    " Set an indentation level of 2 spaces for JavaScript and TypeScript files
    au BufRead,BufNewFile *.js,*.jsx,*.mjs,*.ts,*.tsx setlocal shiftwidth=2 softtabstop=2
    " Same for CSS-family files
    au BufRead,BufNewFile *.css,*.less,*.scss,*.sass setlocal shiftwidth=2 softtabstop=2
    " Same for markup languages
    au BufRead,BufNewFile *.html,*.md,*.yaml setlocal shiftwidth=2 softtabstop=2
    " Same for other JS-adjacent file types
    au BufRead,BufNewFile *.graphql,*.json setlocal shiftwidth=2 softtabstop=2
augroup END

" Ruby
" ----
augroup rb
    au!

    " Set filetype correctly for Podfiles
    au BufNewFile,BufRead Podfile setlocal syntax=ruby
augroup END

" Email
" -----
augroup eml
    au!

    " Set the textwidth to the smaller standard 72 chars for emails
    au BufRead,BufNewFile *.eml setlocal textwidth=72
augroup END

" ===============
" EDITOR SETTINGS
" ===============

" Text Editing
" ------------
" Turn on filetype detection and plugin/indent info loading
filetype plugin indent on
" Use 4-space indentation
set shiftwidth=4
set softtabstop=4
set expandtab
" Auto-indent on new lines
set autoindent
" Don't insert two spaces after certain characters when using a join command
set nojoinspaces
" Wrap to 100 characters
set textwidth=100
" Format options (default fo=jcroql)
set fo=ca " Auto-wrap comments to textwidth
set fo+=r " Auto-insert the current comment leader when pressing enter in insert mode
set fo+=o " Auto-insert the current comment leader when entering new lines with o
set fo+=q " Allow `gq` to format comments
set fo+=w " Use a single trailing whitespace character to indicate continuing paragraphs
set fo+=n " Format numbered lists as well
set fo+=j " Auto-remove comment characters when joining lines
" Let me type my own name
inoremap <M-o> ø

" Text Display
" ------------
" Display tab characters with a width of 8 spaces
set tabstop=8
" Set the number of lines to keep visible above and below the cursor at the top and bottom of the
" screen
set scrolloff=2
" Don't soft-wrap long lines to display them in the buffer
set nowrap
" Display line numbers in the sidebar
set number
" Display line numbers for every line but the current one as an offset
set relativenumber

" Searching
" ---------
" Jump to search results as the search pattern is typed
set incsearch
" Ignore case in search results by default
set ignorecase
" Don't ignore case if the search pattern contains uppercase characters
set smartcase
" Vertically centre search results in the buffer when jumping to them
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" Turn on magic options for searching by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
" Set the grep program to ag or rg (preferred) if available
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Utility
" -------
" Use undo files for permanent undo history
set undodir=~/.local/share/nvim/did
set undofile
" Hide buffers when they're abandoned rather than unloading them
set hidden
" Set up wildmenu for decent completions
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Annoyance Fixes
" ---------------
" Split in sane directions by default
set splitright
set splitbelow
" Reduce the time before vim executes a command
set timeoutlen=300

" Platform Specific
" -----------------
let OS=substitute(system('uname -s'),"\n","","")
if (OS == "Darwin")
    " macOS Specific Settings
elseif ( OS == 'Linux' )
    " Linux Specific Settings
endif

" ==================
" KEYBOARD SHORTCUTS
" ==================

" Quick-save with <leader>w
nmap <leader>w :w<CR>

" Write buffer through sudo
cnoreabbrev w!! w !sudo tee % >/dev/null

" Suspend nvim
nnoremap <leader>ss :sus<cr>

" Copy and paste to/from system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Quick switch between the last two buffers using <leader><leader>
nnoremap <leader><leader> <c-^>

" Open a new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Toggle search highlighting
nmap <silent> <leader>/ :set hlsearch!<cr>

" Run a Rg search with <leader>s
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" Create splits with <leader>s and a direction
nmap <silent> <leader>sh :leftabove vnew<cr>
nmap <silent> <leader>sl :rightbelow vnew<cr>
nmap <silent> <leader>sk :leftabove new<cr>
nmap <silent> <leader>sj :rightbelow new<cr>

" Move between splits with C and a direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Run make from the current directory
noremap M :make<cr>
" Run make from the directory containing the current file
noremap MM :!cd "%:p:h" \| make<cr>
