" CVS dos shell will call cygwin bash shell to run cvs
" CVS dos shell will call cygwin cvs program to run cvs
" PROBLEMS:
" - need --login so cygwin can find cvs* files and cygpath
" - --login change directory to user home directory
" - cygpath to convert "C:\backup" to "/cygdrive/c/backup"
" - output from the cvs scripts will have ^M when viewed in a Vim window
"

nmap _cvsli_ :!/cygwin/bin/cvs login<CR>
nmap _cvslo_ :!/cygwin/bin/cvs logout<CR>
nmap _cvsupA_ :!/cygwin/bin/cvs up -A %:.:gs?\\?\/?<CR>
nmap _cvsup_ :!/cygwin/bin/cvs up %:.:gs?\\?\/?<CR>
nmap _cvsulc_ :!/cygwin/bin/cvs adm -u %:.:gs?\\?\/?<CR>
nmap _cvslc_ :!/cygwin/bin/cvs adm -l %:.:gs?\\?\/?<CR>
nmap _cvsru_ :silent !del %<CR>:!/cygwin/bin/cvs up %:.:gs?\\?\/?<CR>
nmap _cvsh_ :!/cygwin/bin/cvs log %:.:gs?\\?\/? \| /cygwin/bin/grep '^head'<CR>
nmap _cvslg_ :!/cygwin/bin/cvs log -d"-1 day ago" %:.:gs?\\?\/?<CR>
nmap _cvstu_ :!/cygwin/bin/cvs up -r build %:.:gs?\\?\/?<CR>
nmap _cvstF_ :!/cygwin/bin/cvs tag -F build %:.:gs?\\?\/?<CR>
nmap _cvss_ :!/cygwin/bin/cvs status %:.:gs?\\?\/?<CR>
nmap _cvsmod_ :!/cygwin/bin/cvs -n up %:.:gs?\\?\/?<CR>
nmap _cvsd_ :e $TMP\diff<CR>:r!/cygwin/bin/cvs diff -w #:.:gs?\\?\/?<CR>gg
nmap _cvsv_ :e $TMP\view<CR>:r!/cygwin/bin/cvs up -p #:.:gs?\\?\/?<CR>gg
nmap _cvslga_ :e $TMP\view<CR>:r!/cygwin/bin/cvs log #:.:gs?\\?\/?<CR>gg

nmap _ecvs_ :!/cygwin/bin/cvs  -l %:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap _ecvsci_ :!/cygwin/bin/cvs ci -l -m "" %:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap _ecvstF_ :!/cygwin/bin/cvs tag -F build %:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap _ecvsd_ :e $TMP\diff<CR>:r!/cygwin/bin/cvs diff -r -w #:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap _ecvsup_ :!/cygwin/bin/cvs up -l -r %:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap _ecvsv_ :e $TMP\view<CR>:r!/cygwin/bin/cvs up -p -r #:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap _ecvsm_ :!/cygwin/bin/cvs adm -m:"" %:.:gs?\\?\/?<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

nmap <F11>i _ecvsci_
nmap <F11>m _ecvsm_
nmap <F11>t _ecvstF_

nmap _fcvsu_ :!cvsu <C-R><C-F><CR>
nmap _fcvsl_ :!cvsl <C-R><C-F><CR>
nmap _fcvsru_ :!cvsru <C-R><C-F><CR>
nmap _fcvsh_ :!cvsh <C-R><C-F><CR>
nmap _fcvslog_ :!cvslog <C-R><C-F><CR>
nmap _fcvsmod_ :!cvsmod <C-R><C-F><CR>


