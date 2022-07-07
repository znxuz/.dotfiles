ino <silent><expr> <c-@> coc#refresh()
nn <silent> gd <Plug>(coc-definition)
nn <silent> gy <Plug>(coc-type-definition)
nn <silent> gi <Plug>(coc-implementation)
nn <silent> gr <Plug>(coc-references)
nn <silent> [g <Plug>(coc-diagnostic-prev)
nn <silent> ]g <Plug>(coc-diagnostic-next)
nn <leader>g <cmd>CocDiagnostics<cr>
nn <leader>r <Plug>(coc-rename)
nn <leader>a <Plug>(coc-codeaction)
xn <leader>a <Plug>(coc-codeaction-selected)
nn <leader>ca <Plug>(coc-fix-current)
nn <leader>cl <Plug>(coc-codelens-action)

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
	call CocActionAsync('doHover')
    else
	call feedkeys('K', 'in')
    endif
endfunction
nn gh <cmd>call ShowDocumentation()<CR>

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.

nn <silent><nowait><expr> <c-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-e>"
nn <silent><nowait><expr> <c-y> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-y>"
ino <silent><nowait><expr> <c-e> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<c-e>"
ino <silent><nowait><expr> <c-y> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<c-y>"
vn <silent><nowait><expr> <c-e> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-e>"
vn <silent><nowait><expr> <c-y> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-y>"

nn <silent> <c-s> <Plug>(coc-range-select)
xn <silent> <c-s> <Plug>(coc-range-select)
" NOTE: Requires 'textDocument/selectionRange' support of language server.

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:OI` command for organize imports of the current buffer.
command! -nargs=0 OI :call CocActionAsync('runCommand', 'editor.action.organizeImport')
