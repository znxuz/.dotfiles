if has('nvim')
	set guicursor=n-v-c-a:block,i-ci-c:ver1
else
	let &t_EI .= "\<Esc>[2 q"
	let &t_SI .= "\<Esc>[6 q"
	set syntax=on
	set noesckeys
	set nocompatible
	set backspace=indent,eol,start
	set viminfo+=n~/.vim/viminfo
	set t_vb =
	filetype plugin indent on
endif

" basics
	let mapleader=","
	set hidden
	set path+=$HOME/.scripts/**,**
	set exrc secure
	set number rnu
	set splitright splitbelow
	set novisualbell noerrorbells
	set clipboard=unnamedplus
	set colorcolumn=80
	set ttimeoutlen=0
	set nosc

" search
	set incsearch
	set nohls
	set ignorecase
	set smartcase
	nnoremap // /\<\><left><left>
	nnoremap <leader>/ <CMD>let @/ = ""<CR>

" file management
	set noswapfile
	set nobackup
	set undodir=$HOME/.local/share/nvim/undodir
	set undofile
	nnoremap <leader>ec :e <C-R>=expand("%:p:h:t")<CR>/

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full
	inoremap <leader><TAB> <C-x><C-f>

" change working dir
	nnoremap <leader>cd <CMD>cd %:p:h<CR>
	autocmd BufEnter * if isdirectory(expand('%:p')) | :cd %:p:h | :bd

" save session
	nnoremap <A-s> <CMD>wa \| mks! \| qa<CR>

" invoke terminal
	nnoremap <leader>t <CMD>sp \| resize 15 \| term<CR>

" snippets
	nnoremap ]bash <CMD>-1read $HOME/.config/nvim/templates/bash.sh \| w \| e<CR><CR>

" netrw
	let g:netrw_banner=0
	let g:netrw_altv=1
	let g:netrw_liststyle=3
	let g:netrw_browse_split=4
	let g:netrw_winsize = 25

" stautus line
	function! GetMode()
		let l:mode = toupper(mode())
		return '  '.l:mode.' '
	endfunction
	function! GetSep()
		return ' | '
	endfunction
	set noshowmode
	set laststatus=2
	set statusline=
	set statusline+=%#Pmenu#%{GetMode()}%#LineNr#
	set statusline+=%#Pmenu#%{&readonly?GetSep().'RO\ ':''}%#LineNr#
	set statusline+=%#Pmenu#%{&paste?GetSep().'P\ ':''}%#LineNr#
	set statusline+=%<%{'\ \ '.substitute(getcwd(),\ '/home/zijian',\ '~',\ '')}%{'\ '}
	set statusline+=%{fnamemodify(expand('%:p'),\ ':.')==''?'':GetSep()}
	set statusline+=%{fnamemodify(expand('%:p'),\ ':.')}
	set statusline+=%{&modified?'\ '.GetSep().'[+]':''}
	set statusline+=%=
	set statusline+=%{'\ \ '.&fileformat}%{'\ '.GetSep()}
	set statusline+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.GetSep()}
	set statusline+=%l:%c%{GetSep()}
	set statusline+=%p%%
	set statusline+=\ %#Pmenu#\ %Y%{'\ '}
