nnoremap <leader>e :NvimTreeToggle<CR>

let g:nvim_tree_side = 'left'
let g:nvim_tree_width = 25
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 0
let g:nvim_tree_auto_close = 0
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_hide_dotfiles = 0
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_width_allow_resize  = 1
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ]
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 0,
    \ 'files': 0,
    \ }
highlight NvimTreeFolderIcon guibg=blue
