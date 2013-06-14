" Balkian

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle "gmarik/vundle"
Bundle "LaTeX-Box-Team/LaTeX-Box"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-unimpaired"
Bundle "tpope/vim-fugitive"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/nerdcommenter"
Bundle "scrooloose/syntastic"
Bundle "ervandew/supertab"
Bundle "majutsushi/tagbar"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"
Bundle "SpellCheck"
Bundle "mattn/gist-vim"
Bundle "mattn/webapi-vim"
Bundle "kien/ctrlp.vim.git"
Bundle "klen/python-mode"
Bundle "flazz/vim-colorschemes"
Bundle "Lokaltog/vim-distinguished"

filetype plugin indent on     " required!

set hidden " To start working with buffers instead of tabs

highlight SpecialKey ctermfg=DarkGray
set listchars=tab:>-,trail:~
set list
set tabstop=4
set shiftwidth=4
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
au FileType py set textwidth=79
autocmd Filetype javascript set ts=4 sts=4 sw=4 expandtab smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set expandtab
set smarttab
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

set ruler
set wildmenu
set autoread
"Better Map Leader
let mapleader=","
noremap \ ,

" Commenting blocks of code. I don't need it with NerdCommenter
" autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
" autocmd FileType sh,ruby,python   let b:comment_leader = '# '
" autocmd FileType conf,fstab       let b:comment_leader = '# '
" autocmd FileType tex              let b:comment_leader = '% '
" autocmd FileType mail             let b:comment_leader = '> '
" autocmd FileType vim              let b:comment_leader = '" '
" noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
" noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" 
imap <C-v> <C-O>"+gP
noremap <C-S>  :w<CR>
imap <C-S>  <C-O>:w<CR>

"Custom maps
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>t :TagbarToggle<CR>
noremap <Leader>f :CtrlPBuffer<CR>
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

" Color and shit
set t_Co=256
set background=dark
colo solarized
"hi SpellBad ctermfg=Red

"Statusline

set statusline=%t%h%m%r%y%{fugitive#statusline()}\%=[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ \ %c,%l/%L\ %P
set laststatus=2

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Red ctermbg=Red guifg=White ctermfg=White
  elseif a:mode == 'r'
    hi statusline guibg=Blue ctermfg=White guifg=White ctermbg=Blue
  else
    hi statusline ctermbg=Yellow guibg=Yellow ctermfg=Black guifg=Black
  endif
endfunction

call InsertStatuslineColor('')

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertStatuslineColor('')

"Diff the buffer and the original
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

let g:ctrlp_cmd = 'CtrlPBuffer'

set guifont=DejaVu\ Sans\ Mono

set foldmethod=syntax
