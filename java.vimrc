" Simon Chiu 22 Jan 2000
" '<,'>s/^\w*$/		<option value="&">&/
" swap position for | delimited fields
" :s/\(\([^|]*|\)\{4}\)\(\([^|]*|\)\{2}\)/\3\1/

set ignorecase tabstop=4 noexpandtab shiftwidth=4
" Java Compiler

"<dos>
" set makeprg=javac\ -Xstdout\ %
" set makeprg=javac\ -Xstdout\ -deprecation\ %
" set makeprg=javac\ -Xstdout\ -Djava.compiler=NONE\ %
" set makeprg=javac\ -Xstdout\ -g\ %
" set makeprg=javac\ -Xstdout\ -nowarn\ %
" set makeprg=jikes\ -Xstdout\ %:.:gs?\\?/?
set makeprg=jikes\ +E\ -Xstdout\ %:.:gs?\\?/?
nmap _xj_ :execute '!java -Xms10M -Xmx150M ' . GetClassPath(expand("%:h"), expand("%:t:r"))<CR>
" nmap _xj_ :execute '!java -Xrunhprof:cpu=samples,depth=12,thread=y -Xms10M -Xmx150M ' . GetClassPath(expand("%:h"), expand("%:t:r"))<CR>
" nmap _xj_ :execute '!java ' . GetClassPath(expand("%:h"), expand("%:t:r"))<CR>
set errorformat=%f:%l:%c:%*\\d:%*\\d:%m
" set errorformat=%A%f:%l:%c:%*\\d:%*\\d:
" set errorformat+=\%C%*\\s%trror:%m
" set errorformat+=\%+C%*[^:]%trror:%m
" set errorformat+=\%C%*\\s%tarning:%m
" set errorformat+=\%C%m

set makeef=$TMP\error.err
"</dos>

"<cygwin>
" for mswin with jdk1.3 (J2SDK1.3) which has no -Xstdout option: Use Jikes
" TROUBLESHOOT: if nameless buffer shows up after compile, check the file name and error format should get the file name correctly
" set makeprg=bash\ --login\ -c\ \"jikes\ -Xstdout\ +E\ %:.:gs?\\?/?\"
" nmap _xj_ :!bash --login -c "java %:h:gs?[\/]?.?.%:t:r"<CR>
" nmap _jc_ :!bash --login -c "java %:t:r"<CR>
" set errorformat=%f:%l:%c:%*\\d:%*\\d:%m
" set makeef=$HOME/tmp/error.err
"</cygwin>

"<linux>
" set shellpipe=2>&1\|\ tee
" set makeprg=jikes\ -Xstdout\ +E\ %:.:gs?\\?/?
" nmap _xj_ :execute '!java ' . GetClassPath(expand("%:h:gs?[\/]?.?.%:t:r"), expand("%:t:r")<CR>
" set errorformat=%f:%l:%c:%*\\d:%*\\d:%m
" set makeef=$HOME/tmp/error.err
"</linux>

function! GetClassPath(path, name)
    if a:path == ""
        return a:name
    endif

    let $package = substitute(a:path, '^[\/]', '', '')
    let $package = substitute($package, '[\/]', '.', 'g')
    return $package . '.' . a:name
endfunction

iab serr System.err.println();<left><left>
iab sout System.out.println();<left><left>
iab vmain public static void main(String[] args)
iab jda @author Simon Chiu
iab jdp @param 
iab jdr @return  
iab pst printStackTrace()

function! Java2Sql()
	let save_search=@/
	s/^[^"]*"\(.*\)"[^"]*$/\1/
	s/^\s*\*//
	let @/=$save_search
endfunction

nmap _jvm_ :e $VIMRC_HOME/java.vimrc<CR>

" Edit
nmap _j2s_ :call Java2Sql()<CR>

" Open Java File
nmap _je_ gg/\<class\><CR>/\<extends\><CR>w_wj_
nmap _jm_ /\(\(public\)\\|\(private\)\\|\(protected\)\).*\<<C-R><C-W>\><CR>
nmap _fj_ :find <C-R><C-W>.java<CR>
nmap _fj/_ :find +/<C-R>/ <C-R><C-W>.java<CR>
nmap _fx_ :find <C-R><C-W>.xml<CR>
nmap _fd_ :find <C-R><C-W>.dtd<CR>

" Ant
nmap _xa_ :!ant <CR>
nmap _xaf_ :!ant -buildfile %<CR>
nmap _xab_ :!ant<CR>
nmap _ea_ :!ant 
nmap _eaf_ :!ant -buildfile % 
nmap _eab_ :!ant -buildfile build/build.xml 
nmap <F7> _ea_
nmap <F8> _ea_work-webapp
nmap <F9> _ea_work-compile

" Tomcat
let $TOMCAT_HOME='\tomcat'
let $tomcat='shutdown'
nmap _ta_ :if $tomcat == 'startup'<CR>let $tomcat='shutdown'<CR>else<CR>let $tomcat='startup'<CR>endif<CR>:echo $tomcat<CR>
nmap _tx_ :execute 'silent !\%TOMCAT_HOME\%\bin\' . $tomcat<CR>
nmap _te_ :let $tomcat='shutdown'<CR>_tx_
nmap _tr_ :let $tomcat='shutdown'<CR>_tx__tt_
nmap _tt_ _ta__tx_
" let $CATALINA_HOME='\local\tomcat-4.0.3'
" nmap _tx_ :execute 'silent !\%CATALINA_HOME\%\bin\' . $tomcat<CR>
" nmap _tr_ :let $tomcat='shutdown'<CR>_tx_:sleep 5<CR>_tt_

" Websphere
let $WEBSPHERE_HOME='\WebSphere'
let $websphere='stopServer'
nmap _wa_ :if $websphere == 'startServer'<CR>let $websphere='stopServer'<CR>else<CR>let $websphere='startServer'<CR>endif<CR>:echo $websphere<CR>
nmap _wx_ :execute 'silent !\%WEBSPHERE_HOME\%\AppServer\bin\' . $websphere<CR>
nmap _we_ :let $websphere='stopServer'<CR>_wx_
nmap _wr_ :let $websphere='stopServer'<CR>_wx__wt_
nmap _wt_ _wa__wx_

" hsqldb
let $HSQLDB_HOME='\local\hsqldb'
let $hsqldb='runServer -database pmowork -port 9002'
nmap _dt_ :execute 'silent !\%HSQLDB_HOME\%\demo\' . $hsqldb<CR>

