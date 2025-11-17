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
	let l:stop_dir = $HOME
	while 1
		if filereadable(l:search_dir . '/Makefile')
			break
		elseif filereadable(l:search_dir . '/CMakeLists.txt')
			setlocal makeprg=cmake\ --build\ build
			nn <buffer> <leader>mM <cmd>make --clean-first<cr>
			nn <buffer> <leader>MM <cmd>make --clean-first<cr>
			break
		elseif l:search_dir ==# l:stop_dir || l:search_dir == '/'
			break
		endif
		let l:search_dir = fnamemodify(l:search_dir, ':h')
	endwhile
endfunction

call s:ConfigureCppMakeprg()
