vim.cmd [[
let g:vimwiki_list = [
	    \ {
	    \ 'path': '~/Dropbox/notes/misc',
	    \ 'syntax': 'markdown', 'ext': '.md'
	    \ },
	    \ {
	    \ 'path': '~/Dropbox/notes/compsci',
	    \ 'syntax': 'markdown', 'ext': '.md'
	    \ },
	    \ {
	    \ 'path': '~/Dropbox/notes/fh',
	    \ 'syntax': 'markdown', 'ext': '.md'
	    \ },
	    \ ]

let g:vimwiki_key_mappings =
	    \ {
	    \ 'headers': 0,
            \ 'lists': 0,
	    \ }

nnoremap - <Plug>VimwikiGoBackLink
]]
