"setlocal formatoptions+=wa

function! SyncTexForward()
     let execstr = "silent !okular --unique ".LatexBox_GetOutputFile()."\\#src:".line(".")."%:p &"
     exec execstr
endfunction
nmap <Leader>f :call SyncTexForward()<CR>
map <leader>ct yyp:s/begin/end/<CR>

"Latex
let g:tex_flavor = "latex"
set suffixes+=.log,.aux,.bbl,.blg,.idx,.ilg,.ind,.out,.pdf

let g:LatexBox_latexmk_options="-pvc"
let g:Tex_CompileRule_pdf = 'pdflatex --synctex=1 -interaction=nonstopmode $*'
let g:LatexBox_output_type="pdf"
let g:LatexBox_viewer="okular --unique"


let tlist_tex_settings = 'latex;l:labels;s:sections;t:subsections;u:subsubsections'
