syntax on 
"set guifont=Source_Code_Pro:h16:cANSI:qDRAFT
"set guioptions =
set number
set relativenumber
set noerrorbells
set belloff=all
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set grepprg=rg\ --vimgrep
set backspace=indent,eol,start " backspace over everything in insert mode
set splitright
set modifiable
set buftype=

vnoremap <C-c> "+y
nmap <C-v> "+P
"vnoremap <C-c> "*y :let @+@*<CR>

"vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

tnoremap <Esc> <C-\><C-n>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap % %%<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
"call plug#begin()
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim'
Plug 'jpalardy/vim-slime'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'jremmen/vim-ripgrep'
"Plug 'tpope/vim-fugitive'
"Plug 'leafgarland/typescript-vim'
"Plug 'vim-utils/vim-man'
"Plug 'lyuts/vim-rtags'

"Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
call plug#end()
colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

"let g:user_emmet_install_global = 0
"autocmd FileType html,css,javascript.jsx,liquid EmmetInstall
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"let g:user_emmet_settings = {
"\  'javascript' : {
"\      'extends' : 'jsx',
"\  },
"\}


let mapleader = " "

"let g:user_emmet_leader_key='<C-I>'
let g:user_emmet_leader_key=','
"let g:user_emmet_expandabbr_key='<Tab>'
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 35

let g:ctrlp_use_caching = 0
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>tt :w<CR>:!%p<CR> :wincmd h<bar> :below term<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>

set makeprg=python\ %
set makeprg=gcc\ %
set makeprg=gcc\ %\ &&\ ./a.out
set makeprg=cabal\ repl


" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"SLIME
let g:slime_target = "tmux"
let g:slime_bracketed_paste = 1
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":1.1"}
"let g:slime_target = "neovim"
if !exists("g:slime_dispatch_ipython_pause")
  let g:slime_dispatch_ipython_pause = 100
end

function! _EscapeText_python(text)
  if exists('g:slime_python_ipython') && g:slime_python_ipython && len(split(a:text,"\n")) > 1
    return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--\n"]
  else
    let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
    let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
    let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
    let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
    let except_pat = '\(elif\|else\|except\|finally\)\@!'
    let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
    return substitute(dedented_lines, add_eol_pat, "\n", "g")
  end
endfunction
