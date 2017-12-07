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
Bundle "tpope/vim-abolish.git"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/nerdcommenter"
Bundle "scrooloose/syntastic"
Bundle "ervandew/supertab"
Bundle "majutsushi/tagbar"
Bundle "MarcWeber/vim-addon-mw-utils"
"" for vim-snippets
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"
Bundle "mattn/webapi-vim"
Bundle "mattn/gist-vim"
Bundle "klen/python-mode"
Bundle "ivanov/vim-ipython"
Bundle "jamessan/vim-gnupg"
Bundle "Lokaltog/vim-easymotion"
Bundle "vim-scripts/YankRing.vim"
Bundle "kien/ctrlp.vim.git"
Bundle "sgur/ctrlp-extensions.vim"
Bundle "sjl/gundo.vim"
Bundle "bling/vim-airline"
Bundle 'vim-airline/vim-airline-themes'
Bundle "xolox/vim-misc"
Bundle "xolox/vim-notes"
Bundle "beloglazov/vim-online-thesaurus"
Bundle "vim-scripts/ShowMarks"
Bundle "atweiden/vim-dragvisuals"
Bundle "tomasr/molokai"
Bundle "elzr/vim-json"
Bundle 'Rykka/riv.vim'
Bundle "niklasl/vim-rdf"
Bundle "lepture/vim-jinja"



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

" faster commands
noremap <space> :
" Better Map Leader
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
noremap <Leader>t :TagbarOpen fj<CR>
noremap <Leader>f :CtrlPMixed<CR>
noremap <Leader>b :CtrlPBookmarkDir<CR>
noremap <Leader>l :CtrlPLine<CR>
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
nnoremap <Leader>dd :bd<CR>


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
"colo solarized 
colo molokai
"hi SpellBad ctermfg=Red

"Statusline

set statusline=%t%h%m%r%y%{fugitive#statusline()}\%=[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ \ %c,%l/%L\ %P
set laststatus=2

" Now that I use Airline, there is no need for this :)
"function! InsertStatuslineColor(mode)
  "if a:mode == 'i'
    "hi statusline guibg=Red ctermbg=Red guifg=White ctermfg=White
  "elseif a:mode == 'r'
    "hi statusline guibg=Blue ctermfg=White guifg=White ctermbg=Blue
  "else
    "hi statusline ctermbg=Yellow guibg=Yellow ctermfg=Black guifg=Black
  "endif
"endfunction

"call InsertStatuslineColor('')
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * call InsertStatuslineColor('')

au BufRead,BufNewFile *.md set filetype=markdown

"Diff the buffer and the original
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

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

" CtrlP
" Do not clear the file cache on exit
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = [ 'mixed' ]
let g:ctrlp_regexp = 0
let g:ctrlp_cmd = 'CtrlPMixed'

" Git things
nmap <leader>gs :Gstatus<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gl :Glog<cr>

" Gundo magic
nnoremap <leader>u :GundoToggle<CR>

" YankRing+Ctrl-P
map <leader>y :YRShow<CR>
let g:yankring_replace_n_pkey = '<c-j>'
let g:yankring_replace_n_nkey = '<c-k>'


let g:airline_left_sep=''
let g:airline_right_sep='|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='base16'

" Notes
:let g:notes_directories = ['~/Dropbox/Notes']

" Block move
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" Thesaurus
let g:online_thesaurus_map_keys = 0
nnoremap <leader>k :OnlineThesaurusCurrentWord<CR>
vnoremap <leader>k <Esc>:Thesaurus <C-R><C-R>=<SID>get_visual_selection()<CR><CR>

" Resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Clipboard magic
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

set cursorline

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

let g:pymode_rope_project_root = "~/.ropeprojects"

" backup to ~/.tmp 
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
nmap <Leader>w <Plug>(easymotion-bd-w)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1
