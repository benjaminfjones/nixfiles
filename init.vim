" init.vim  -- neovim 0.5+ configuration
"
" Author: Benjamin Jones <benjaminfjones@gmail.com>
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prelude

" Set the leader as ';' instead of '\'
let mapleader      = ";"
let maplocalleader = ";"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins (vim-plug)

call plug#begin(stdpath('data') . '/plugin-home')

" The Pope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'itchyny/lightline.vim'
set laststatus=2  " enable status line and message line
set noshowmode    " turn off redundant mode display
let g:lightline = {
      \  'colorscheme': 'solarized',
      \  'active': {
      \    'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'relativepath' ] ],
      \    'right': [ [ 'percent', 'lineinfo', 'formatoptions' ], [ 'filetype' ] ]
      \  },
      \  'component': {
      \    'formatoptions': '[%{&fo}]'
      \  }
      \}


" fzf and fzf.vim:  https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" *** Mappings ***
" git tracked files
nmap <space> :GFiles<CR>
nmap <Leader>f :GFiles<CR>
" all files
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
" current buffer lines
nmap <Leader>l :BLines<CR>
" all open buffer lines
nmap <Leader>L :Lines<CR>
" Brazil ws version of :Files
command! -bang WSFiles call fzf#vim#files('../', <bang>0)

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" wiki
Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'
let g:wiki_root = '~/vimwiki'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" CoC specific settings
runtime coc-settings.vim

" nvim LSP config
" Plug 'neovim/nvim-lspconfig'


" Colors scheme plugins
" Plug 'altercation/vim-colors-solarized'
" Plug 'luochen1990/rainbow'
" Plug 'chuling/ci_dark'
Plug 'lifepillar/vim-solarized8'

" vim-startify
Plug 'mhinz/vim-startify'
let g:startify_change_to_vcs_root = 0

" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Rustfmt support
Plug 'rust-lang/rust.vim'

" ALE for extra linting and auto-formatting
Plug 'dense-analysis/ale'
let g:ale_fixers = {'rust': ['rustfmt']}
let g:ale_fix_on_save = 1


call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Runtime plugin setup
"

" nvim-lspconfig setup
" lua << EOF
" require'lspconfig'.pyright.setup{}

" -- see https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
" local nvim_lsp = require('lspconfig')

" -- Use an on_attach function to only map the following keys
" -- after the language server attaches to the current buffer
" local on_attach = function(client, bufnr)
"   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
"   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

"   -- Enable completion triggered by <c-x><c-o>
"   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

"   -- Mappings.
"   local opts = { noremap=true, silent=true }

"   -- See `:help vim.lsp.*` for documentation on any of the below functions
"   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
"   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
"   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
"   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
"   -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
"   -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
"   -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
"   -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"   -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"   -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
"   -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
"   -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
"   -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

" end

" -- Use a loop to conveniently call 'setup' on multiple servers and
" -- map buffer local keybindings when the language server attaches
" -- local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
" local servers = { 'pyright' }
" for _, lsp in ipairs(servers) do
"   nvim_lsp[lsp].setup {
"     on_attach = on_attach,
"     flags = {
"       debounce_text_changes = 150,
"     }
"   }
" end
" EOF

" nvim-treesitter setup
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "json", "python", "rust" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Post-plugin options
"



" Enable filetype detection
filetype plugin indent on

" ignore case when all letters are lower case
set ignorecase smartcase

" Allow backspacing over everything
set backspace=indent,eol,start

" Incremental searching
set incsearch

" Cursor context
set scrolloff=3

" Always show cursor position
set ruler

" Fold by manually defined folds
set nofoldenable

" Syntax
syntax enable
set hlsearch

" Spell checking
if has("spell")
    setlocal spell spelllang=en_us
    set nospell
endif

" set text wrap width
set textwidth=78

" Highlight trailing space, and tab characters
set list
set listchars=tab:▸·,trail:·

" Completion options
set wildmode=longest:full,list:full
set wildmenu
set wildignore=*.o,*.hi,*.swp,*.bc

syntax on
set termguicolors
colorscheme solarized8

set fillchars+=vert:│

" reset highlighting
highlight Normal cterm=NONE ctermbg=NONE
highlight SignColumn ctermbg=Black

" Grey cursor line/col highlights
highlight CursorLine   term=bold cterm=bold guibg=Grey40
highlight CursorColumn term=bold cterm=bold guibg=Grey40

" Disable the bell
set noerrorbells
set visualbell
set t_vb=

" Tabs and Indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set breakindent
set autoindent
set smartindent
set expandtab

" Row/Column accents
set nocursorcolumn
set nocursorline
set nonumber
set norelativenumber

" Join spaces: when joining lines or reflowing paragraphs, only use one space
" to separate sentences, not two
set nojoinspaces


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TABS

" Tab/buffer navigation
function! Next()
    if tabpagenr('$') > 1
        tabnext
    else
        bnext
    endif
endfunction

function! Prev()
    if tabpagenr('$') > 1
        tabprevious
    else
        bprevious
    endif
endfunction

nnoremap <silent> <C-n> :call Next()<Cr>
nnoremap <silent> <C-p> :call Prev()<Cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL mode mappings

" Define double <leader> to kill the search highlighting.
nnoremap <Leader><Leader> :noh<Enter>
" set cursorline
nnoremap <Leader>c :set cursorcolumn!<CR>
nnoremap <Leader>C :set cursorline!<CR>
" uppercase the current word, put cursor after last char
nnoremap <c-u> viwUea
" edit $VIMRC in a split
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
" source $VIMRC
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Disable the help key
nnoremap <F1> <Esc>
" Set F2 as the binding to toggle the paste mode
set pastetoggle=<F2>
" Use F3 to toggle spelling
nnoremap <F3> :set spell!<CR>
" remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" insert timestamp
nnoremap <Leader>tt i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INSERT mode mappings

" Disable the help key
inoremap <F1> <Esc>
" jk trick!
inoremap jk <Esc>
" Crtl-d to delete current line
inoremap <c-d> <ESC>ddi
" uppercase current word, put cursor back insert mode after last char
inoremap <c-u> <ESC>viwUea

" Disable the arrow keys when in edit mode
inoremap <Up>    <NOP>
inoremap <Right> <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations

iabbrev adn and
iabbrev waht what
iabbrev tehn then
