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
Bundle "tpope/vim-surround.git"
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
Bundle "jamessan/vim-gnupg"
Bundle "Lokaltog/vim-easymotion"
"Bundle 'chriskempson/base16-vim'
Bundle "fholgado/minibufexpl.vim"
Bundle "nanotech/jellybeans.vim"

filetype plugin indent on     " required!

set hidden " To start working with buffers instead of tabs

highlight SpecialKey ctermfg=DarkGray
set listchars=tab:>-,trail:~
set list
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
au FileType py set textwidth=79
au FileType html set tabstop=2 shiftwidth=2
autocmd Filetype javascript set ts=4 sts=4 sw=4 expandtab smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set expandtab
set smarttab
set autoindent
set smartindent
syntax on
set ignorecase
set smartcase
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
map <leader>p "+gp
map <leader>P "+gP
noremap <C-S>  :w<CR>
imap <C-S>  <C-O>:w<CR>

"Custom maps
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>t :TagbarToggle<CR>
noremap <Leader>f :CtrlP<CR>
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

set sessionoptions+=resize,winpos

"autocmd VimEnter * call RestoreSession()

"Make tabs and buffers work better
":se switchbuf=usetab,newtab

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

let g:ctrlp_cmd = 'CtrlPMRU'

set guifont=DejaVu\ Sans\ Mono

set foldmethod=syntax
set foldclose=all
set foldopen+=insert,jump
set nofoldenable

" Matching for html
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

""""""""""""""""""""
" GnuPG Extensions "
""""""""""""""""""""

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

" RDF Notation 3 Syntax
augroup filetypedetect
    au BufNewFile,BufRead *.n3  setfiletype n3
    au BufNewFile,BufRead *.ttl  setfiletype n3
augroup END


function SetGPGOptions()
" Set updatetime to 1 minute.
    set updatetime=60000
" Fold at markers.
    "set foldmethod=marker
    setlocal foldmethod=expr
    setlocal foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
    set foldtext=getline(v:foldstart)

" Automatically close all folds.
    set foldclose=all
" Only open folds with insert commands.
    set foldopen=insert
endfunction

" Do not clear the file cache on exit
let g:ctrlp_clear_cache_on_exit = 0
