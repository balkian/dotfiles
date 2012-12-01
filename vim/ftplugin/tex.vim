setlocal formatoptions+=wa

function! SyncTexForward()
     let execstr = "silent !okular --unique ".LatexBox_GetOutputFile()."\\#src:".line(".")."%:p &"
     exec execstr
endfunction
nmap <Leader>f :call SyncTexForward()<CR>
map <leader>ct yyp:s/begin/end/<CR>



