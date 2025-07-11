fu s:CppCheck()
	try
		let save_makeprg=&makeprg
		setl makeprg=cppcheck
		:make --suppress=missingIncludeSystem --enable=all src/
	finally
		let &makeprg=save_makeprg
	endtry
endfu

"nn <buffer> <leader>mch <cmd>call <sid>CppCheck()<cr>
