" Simon Chiu 22 Jan 2000
" Simon Chiu 24 June 2001 - remove these from java.vimrc and put in customize.vimrc

" augroup cprog
" 	autocmd!
" augroup END

autocmd! BufRead,BufEnter * setlocal expandtab tabstop=4 shiftwidth=4 nonumber foldcolumn=0
autocmd! BufRead,BufEnter *.java,*.php,*.jsp,*.sql setlocal number foldcolumn=0
autocmd! BufRead,BufEnter *.fo,*.xml setlocal foldcolumn=8 foldmethod=indent foldclose&
" autocmd! BufWinLeave *.java mkview
" autocmd! BufWinEnter *.java silent loadview

let g:explVertical=1
let g:explSplitRight=1
let g:explStartRight=0
let g:explWinSize=15
set noequalalways
set winminheight=0
set winminwidth=15
set winwidth=15
set foldclose=all
set foldlevel=1

set splitright
set wildmenu
set wildcharm=<Tab>
set wildignore=*.class,*.bak
set suffixesadd=.java
set showbreak=\ \ \ \ \ \ ~\ 
set cpoptions=aABceFsn
" set number
set statusline=%<%3.3c:%7.6l/%-7.6L:%3.3p%%%=%120.120F%h%m%r
set wrap
set textwidth=0 hidden timeoutlen=2000
set mousehide
set matchpairs=(:),{:},[:],<:>
set shortmess=filnxtToOA
set notimeout
set showmatch nostartofline showcmd noruler cmdheight=2
set report=0 ls=2
" set titlestring=Vim
set titlestring=%<%F%=%l/%L/%P titlelen=70
set titlelen=120
" set titlestring=\ %.50{getcwd()}%)%(\ %a\ (%.70{expand(\"%:p\")})
set formatprg=sort
set incsearch
set hlsearch
set ignorecase

set grepprg=grep\ -n
set grepformat=%f:%l:%m,%l:%m

set cindent cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,ts,c3,+s,(2s,us,)20,*60,gs,hs
set formatoptions=tcroql2

function! Unmap( Map )
	if mapcheck( a:Map ) != ""
		execute "unmap " . a:Map
	endif
	if mapcheck( a:Map, "c" ) != ""
		execute "cunmap " . a:Map
	endif
	if mapcheck( a:Map, "i" ) != ""
		execute "iunmap " . a:Map
	endif
endfunction

call Unmap("<C-A>")
call Unmap("<C-Y>")
call Unmap("<C-R>")

function! Vim( ... ) range
	if a:0 < 1 | return | endif

	let userMap = "_" . a:1 . "_"
	if mapcheck( userMap, "n" ) != ""
		execute "normal " . userMap
        return
	endif

	let userMap = "__" . a:1 . "_"
	if mapcheck( userMap, "n" ) != ""
		execute "normal " . (a:lastline - a:firstline + 1) . userMap
        return
	endif

    echo "Key sequence not mapped: " . a:1
endfunction

command! -range -nargs=* Vim <line1>,<line2> call Vim(<f-args>)

function! FormatHtmlTable() " use white space at columns separator, new line as row separator
	execute '%s/^\s*//'
	execute '%s/\s*$//'
	execute '%s/\s\+/<td><pre>/g'
	execute '%s/^/<tr><td height="30"><pre>/'
	execute 'normal ggO<table border="1" cellspacing="0" cellpadding="0" width="80%" align="center">'
	execute 'normal Go</table>'
endfunction

function! FormatUnixTrimFileList() " remove leading and trailing space and use / not \
	execute '%s/^\s*//'
	execute '%s/\s*$//'
	execute '%s/^\\//'
	execute '%s/\s.*//'
	execute '%s/\\/\//g'
endfunction

function! Count()
    let char = input( "Character : " )
    echo char
endfunction

nmap <CR> :Vim 
vmap <CR> :Vim 
nmap _e_ :e
nmap _fe_ :Sexplore<CR>
nmap _t_ :echo strftime("%b %d %Y %X")<CR>
nmap _ufl_ :call FormatUnixTrimFileList()<CR>
nmap _ht_ :call FormatHtmlTable()<CR>
nmap _dts_ :%s/\s\+$//<CR>
nnoremap _d2u_ :%s/<C-V><C-M>$//<CR>
nmap _ct_ :call Count()<CR>

nmap g/ :let @/='<C-R><C-W>'<CR>
let $quote='"'
let $squote="'"
vmap g/ y:execute '/' . escape(@", '/\\' . $quote . $squote)<CR>
nmap g? :let @/='\<<C-R><C-W>\>'<CR>
vmap g? :<C-U>let @/='\<<C-R><C-W>\>'<CR>

" Folding
nmap _f{_ va{kzf

" Command line
cmap <C-P> <Up>

" cmap <C-N> <Down> would cause ^I to appear when wildmenu is set.
" Apparently because <Tab> which invoke completion doesn't work for a map.
" set wildcharm=<Tab> to solve this problem.
cmap <C-N> <Down>
cmap <C-O> <S-Tab>
cmap <C-A> <Home>
cmap <C-F> <Right>
cmap <C-B> <Left>
cmap <C-D> <Del>
cnoremap <C-L> <C-D>

" Window
nmap <C-J> <C-W>w
nmap <C-K> <C-W>W

" File Types
nmap _dtd_ :set ft=dtd<CR>
nmap _xml_ :set ft=xml<CR>
nmap _java_ :set ft=java<CR>
nmap _html_ :set ft=html<CR>
nmap _vim_ :set ft=vim<CR>
nmap _expect_ :set ft=vim<CR>

" Compile
nmap _p_ :unmap n<CR>:unmap p<CR>
nmap _n_ :unmap n<CR>:unmap p<CR>
nmap _cp_ :nmap n :cn<lt>CR><CR>:nmap p :cp<lt>CR><CR>:cp<CR>
nmap _cn_ :nmap n :cn<lt>CR><CR>:nmap p :cp<lt>CR><CR>:cn<CR>
nmap _cm_ :up<CR>:mak<CR>
nmap _cl_ :cl!<CR>
nmap _cc_ :cc<CR>

" Program Execution
nmap _x_ :!start %:p<CR>

" Cut and Paste
nmap _yw_ viwy
nmap _pw_ viw"_cx<Esc>gP"_x

" Buffer
nmap _cd_ :cd %:h \| :pwd<CR>

function! CloseWindow()
    let closeBuf=bufnr("%")
    let altBuf=bufnr("#")

	if altBuf > 0
		execute 'buffer ' . altBuf
	else
		execute 'new'
	endif
    execute 'bdelete ' . closeBuf
endfunction

nmap <C-BS> :bd<CR>

" Code Comment
function! LineComment() range
    let fileType = &filetype
    let commentStart = ''
    let commentEnd = ''

    if fileType == "vim"
        let commentStart = '" '
    elseif fileType == "java"
        let commentStart = '\/\/ '
    elseif fileType == "html" || fileType == "xml" || fileType == "xsl"
        let commentStart = '<!-- '
        let commentEnd = ' -->'
    elseif fileType == "jsp"
        let commentStart = '<%-- '
        let commentEnd = ' --%>'
    elseif fileType == "sh" || fileType == "conf" || fileType == "expect"
        let commentStart = '# '
    elseif fileType == "sql"
        let commentStart = '-- '
    elseif fileType == "dosbatch"
        let commentStart = 'REM '
    elseif fileType == "c"
        let commentStart = '\/* '
        let commentEnd = ' *\/'
    else
        let commentStart = '# '
    endif
        
    execute a:firstline . ',' . a:lastline . 's/^\(\s*\)\(.*\)$/\1' . commentStart . '\2' . commentEnd . '/'
endfunction

nmap __lc_ :call LineComment()<CR>

function! NoLineComment() range
    let fileType = &filetype
    let commentStart = ''
    let commentEnd = ''

    if fileType == "vim"
        let commentStart = '" '
    elseif fileType == "java"
        let commentStart = '\/\/\s\='
    elseif fileType == "html" || fileType == "xml" || fileType == "xsl"
        let commentStart = '<!--\s\='
        let commentEnd = ' -->'
    elseif fileType == "jsp"
        let commentStart = '<%-- '
        let commentEnd = ' --%>'
    elseif fileType == "sh" || fileType == "conf" || fileType == "expect"
        let commentStart = '#\s\='
    elseif fileType == "sql"
        let commentStart = '-- '
    elseif fileType == "dosbatch"
        let commentStart = 'REM '
    elseif fileType == "c"
        let commentStart = '\/* '
        let commentEnd = ' *\/'
    else
        let commentStart = '#\s\='
    endif
        
    execute a:firstline . ',' . a:lastline . 's/' . commentStart . '\(.*\)' . commentEnd . '/\1/'

endfunction

nmap __nlc_ :call NoLineComment()<CR>

function! BoxComment() range
    let fileType = &filetype
    let commentStart = ''
    let commentEnd = ''

    if "java" == fileType
        let commentStart = '\/*'
        let commentEnd = '*\/'
    elseif "html" == fileType
        let commentStart = '<!-- '
        let commentEnd = ' -->'
    elseif "c" == fileType
        let commentStart = '\/*'
        let commentEnd = '*\/'
    else
        echo 'File type not mapped: ' . fileType
        return
    endif
        
    execute a:lastline 's/$/' . '' . commentEnd . '/'
    execute a:firstline 's/^/' . commentStart . '/'

endfunction

nmap __bc_ :call BoxComment()<CR>

" Inserting Method
function! SetMethodString()
    let $methodString = input("Method: ")
endfunction

function! GetMethodString()
    execute 'normal o' . $methodString . ''
endfunction

nmap _setms_ :call SetMethodString()<CR>
nmap _getms_ :call GetMethodString()<CR>
nmap _iwms_ @='ciw' . $methodString . '( pa )' <CR>
nmap _isms_ @='ct;' . $methodString . '( pa )' <CR>

" Buffer Switching Maintain center page position
nmap <C-N> :bn<CR>
nmap <C-P> :bp<CR>

nmap _ib_ O{<Esc>jo}<Esc>

" Cut / Paste / Delete
map \\regs/\\ :let @t=@/<CR>
map \\regr/\\ :let @/=@t<CR>
map \\regs"\\  :let @t=@"<CR>
map \\regr"\\ :let @"=@t<CR>
vmap p <Esc>\\regs"\\gv<C-G>x<Esc>\\regr"\\"=@".'xy'<CR>gPFx"_3x
map \\regs*\\ :let @t=@*<CR>
map \\regr*\\ :let @*=@t<CR>
nmap _pl_ p2t"<C-A>Y

" Various Maps
nmap \l }p/\d<C-A>Y
nmap _bt_ :s/<[^/]*\/[^>]*>/<C-Q><C-M>&/g<CR>
vmap & :&<CR>

" File Operation
nmap ZR :e!<CR>
nmap ZU :up<CR>
nmap ZZ <Nop>
nmap ZD :bd!<CR>
nmap ZC :bd<CR>
nmap _cj_ :!newer %:r.class %:r.java<CR>

" Motion Scrolling
nmap _sb_ :set scb<CR>
nmap _nsb_ :set noscb<CR>
nmap <Space> <C-D>
nmap <S-Space> <C-U>

" Cursor
" nmap <S-W> B

" Preferences
nmap _vww_ :set wrap<CR>
nmap _vnww_ :set nowrap<CR>
nmap _vm_ :set go+=m<CR>
nmap _vnm_ :set go-=m<CR>

" Register
nmap _p*_ :let @*=@"<CR>
nmap _p/_ :let @/=@"<CR>
nmap _y*_ :let @"=@*<CR>
nmap _y/_ :let @"=@/<CR>
nmap _e"_ :let @*=''<Left>
nmap _e"_ :let @"=''<Left>
nmap _e/_ :let @/=''<Left>

nmap _ns_ :%s/(\s*/(/g<CR>:%s/\s*)/)/g<CR>:%s/\s*$//<CR>
nmap _s_ vip!sort<CR>
nmap - "_

" Selection / Highligth
nmap vi> T>vt<
nmap di> T>dt<
nmap ci> T>ct<
nmap yi> T>yt<
nmap "_di> T>"_dt<
nmap "_ci> T>"_ct<
nmap "_yi> T>"_yt<

