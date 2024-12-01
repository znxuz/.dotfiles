setl cc=80
" setl cino=g0,E-s,N-s,:0,l1
setl cino=h1,l1,g1,t0,i4,+4,(0,w1,W4,E-s,N-s
setl wig+=bin/*,*.o
setl et ts& sts=2 sw=2

fu s:CppCheck()
	try
		let save_makeprg=&makeprg
		setl makeprg=cppcheck
		:make --suppress=missingIncludeSystem --enable=all src/
	finally
		let &makeprg=save_makeprg
	endtry
endfu

nn <buffer> <leader>mch <cmd>call <sid>CppCheck()<cr>
nn <buffer> <leader><c-^> <cmd>ClangdSwitchSourceHeader<cr>
