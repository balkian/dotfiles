" Balkian

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'tpope/vim-fugitive'
Bundle "tpope/vim-unimpaired"
Bundle 'scrooloose/nerdtree'
Bundle 'taglist.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"
Bundle "SpellCheck"
Bundle "mattn/gist-vim"
Bundle "mattn/webapi-vim"

filetype plugin indent on     " required!

set hidden " To start working with buffers instead of tabs

highlight SpecialKey ctermfg=DarkGray
set listchars=tab:>-,trail:~
set list
set tabstop=4
set shiftwidth=4
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd Filetype javascript set ts=4 sts=4 sw=4 expandtab smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set expandtab
set autoindent
set smartindent
syntax on
set ignorecase
set smartcase
set softtabstop=4
set number
"set paste
set mouse=a
set autochdir
set showmatch
set incsearch
set hlsearch 

"Better Map Leader
let mapleader=","
noremap \ ,

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

imap <C-v> <C-O>"+gP<CR>
noremap <C-S>  :w<CR>
imap <C-S>  <C-O>:w<CR>

"Custom maps
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>t :TlistToggle<CR>
"Omni

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
set spell spelllang=en_gb

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
"inoremap <C-t>     <Esc>:tabnew<CR>


" Save sessions
function! RestoreSession()
if argc() == 0 "vim called without arguments
    execute 'source ~/.vim/Session.vim'
  end
endfunction

nmap Sq <ESC>:mksession! ~/.vim/Session.vim<CR>:qa!<CR>
nmap SQ <ESC>:mksession! ~/.vim/Session.vim<CR>:wqa<CR>
nmap SO :so ~/.vim/Session.vim<CR>

"autocmd VimEnter * call RestoreSession()

"Make tabs and buffers work better
:se switchbuf=usetab,newtab
":tab sball

" Color and shit
colo vividchalk
set background=dark
hi SpellBad ctermbg=Red ctermfg=White

"Statusline

set statusline=%t%h%m%r%y%{fugitive#statusline()}\%=[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ \ %c,%l/%L\ %P
set laststatus=2

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Red ctermfg=White guifg=White ctermbg=Red
  elseif a:mode == 'r'
    hi statusline guibg=Blue ctermfg=White guifg=White ctermbg=Blue
  else
    hi statusline guibg=Yellow ctermfg=White guifg=Black ctermbg=Yellow
  endif
endfunction

call InsertStatuslineColor('')

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertStatuslineColor('')


" Encryption
" set cm=blowfish
" Transparent editing of gpg encrypted files.
