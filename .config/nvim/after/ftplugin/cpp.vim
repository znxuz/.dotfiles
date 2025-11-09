function! s:CppCheck()
	try
		let save_makeprg=&makeprg
		setl makeprg=cppcheck
		:make --suppress=missingIncludeSystem --enable=all src/
	finally
		let &makeprg=save_makeprg
	endtry
endfunction

fu! s:ConfigureCppMakeprg()
	let l:search_dir = expand('%:p:h')
	let l:stop_dir = fnamemodify($HOME, ':h')
	while 1
		if filereadable(l:search_dir . '/Makefile')
			return
		endif
		if filereadable(l:search_dir . '/CMakeLists.txt')
			setlocal makeprg=cmake\ --build\ build
			return
		endif
		if l:search_dir ==# l:stop_dir
			break
		endif
		let l:search_dir = fnamemodify(l:search_dir, ':h')
	endwhile
endfunction

call s:ConfigureCppMakeprg()
delfunction s:ConfigureCppMakeprg

nn <buffer> <leader>mM <cmd>make --clean-first<cr>
nn <buffer> <leader>MM <cmd>make --clean-first<cr>
